pipeline {
    agent any

    stages {
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
    }

    post {
        success {
            echo '✅ Kubernetes is reachable!'
        }
        failure {
            echo '❌ Could not connect. Check kubeconfig and network.'
        }
    }
}
