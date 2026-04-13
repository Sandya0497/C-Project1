pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        ECR_REPO   = "678632989999.dkr.ecr.ap-south-1.amazonaws.com/test-project"
         EKS_CLUSTER = 'Testcluster'
    }

    stages {
        stage('Login to ECR') {
            steps {
                withAWS(region: "${AWS_REGION}", credentials: 'aws-creds') {
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
        stage('Deploy to EKS') {
            steps {
                script {
                    sh '''
                        echo "Updating kubeconfig..."
                        mkdir -p /var/lib/jenkins/.kube
                        aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER --kubeconfig /var/lib/jenkins/.kube/config
                        export KUBECONFIG=/var/lib/jenkins/.kube/config

                        echo "Applying Kubernetes manifests..."
                        kubectl apply -f Jenkinsandjava/deployment.yaml --validate=false
                        kubectl apply -f Jenkinsandjava/service.yaml --validate=false
                    '''
                }
            }
        }

    }
}
