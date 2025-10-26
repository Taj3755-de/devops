pipeline {
    agent any

    environment {
        APP_NAME = 'devops-appss'
        REGISTRY = '192.168.31.14:5000' // Jenkins-hosted Docker registry
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

        stage('Push Docker Image') {
            steps {
                sh """
                echo "Pushing image to registry..."
                docker push ${IMAGE}
                """
            }
        }

        stage('Test') {
            steps {
                sh """
                echo "Running tests..."
                # Example: pytest tests/ or npm test
                """
            }
        }

        stage('Check Kubernetes Nodes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh """
                    echo "Listing Kubernetes nodes..."
                    kubectl get nodes
                    """
                }
            }
        }
    } // end of stages

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs!'
        }
    }
}
