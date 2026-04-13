pipeline {
    agent any
    environment {
        AWS_REGION = "ap-south-1"   // change to your region
        ECR_REPO   = "678632989999.dkr.ecr.ap-south-1.amazonaws.com/test-project"
    stages {
       stage('Login to ECR'){
             steps{
              withAWS(region: 'ap-south-1', credentials: 'aws-creds'){
                sh '''
                 $password = aws ecr get-login-password  --region ap-south-1
                 docker login  --username  AWS --password $password 678632989999.dkr.ecr.ap-south-1.amazonaws.com

                 '''

               }           
  
              }

            }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${ECR_REPO}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    sh "docker push ${ECR_REPO}:${env.BUILD_NUMBER}"
                }
            }
        }
    }
    }
}
