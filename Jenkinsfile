pipeline {
    agent any

    environment {
        APP_NAME = 'devops-appss'
        REGISTRY = '192.168.31.14:5000'
        IMAGE = "${REGISTRY}/${APP_NAME}:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Taj3755-de/devops.git', credentialsId: 'kube-jenkins'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                echo "Building Docker image..."
                docker build -t ${IMAGE} .
                """
            }
        }

        stage('Scan Docker Image with Trivy') {
            steps {
                sh """
                echo "Scanning Docker image with Trivy..."
                trivy image --severity HIGH,CRITICAL --exit-code 1 ${IMAGE}
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                echo "Pushing image to registry..."
                docker push ${IMAGE}
                """
            }
        }

        stage('Check Kubernetes Nodes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh "kubectl get nodes"
                }
            }
        }



    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs!'
        }
    }
}
