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

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh """
                    kubectl apply -f k8s-deployment.yaml
                    kubectl apply -f k8s-service.yaml
                    kubectl rollout status deployment/${APP_NAME}
                    kubectl get pods
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs!'
stage('Terraform Security Check') {
    steps {
        dir('terraform-sample') {  // Replace with your Terraform folder
            echo "Initializing Terraform..."
            sh 'terraform init'

            echo "Validating Terraform configuration..."
            sh 'terraform validate'

            echo "Running tfsec security scan..."
            sh '/usr/local/bin/tfsec --severity CRITICAL,HIGH --no-color || exit 1'

            echo "Documenting Terraform security scan results..."
            sh '''
            mkdir -p security-docs
            echo "tfsec scan executed on $(date)" > security-docs/terraform-security-report.txt
            /usr/local/bin/tfsec --format json >> security-docs/terraform-security-report.txt || true
            '''
        }
    }
}
