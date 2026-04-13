pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"   // change to your region
        ECR_REPO   = "678632989999.dkr.ecr.ap-south-1.amazonaws.com/test-project"
        AWS_CREDS  = credentials('aws-creds')
    }

    stages {
        stage('Login to ECR') {
            steps {
                withAWS(region: "${AWS_REGION}", credentials: "${AWS_CREDS}") {
                    sh '''
                        aws ecr get-login-password --region ${AWS_REGION} \
                        | docker login --username AWS --password-stdin 678632989999.dkr.ecr.${AWS_REGION}.amazonaws.com
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
