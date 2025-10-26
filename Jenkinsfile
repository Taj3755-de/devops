pipeline {
    agent any

    stages {
        stage('Check Kubernetes Connectivity') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh """
                    echo "Listing Kubernetes nodes..."
                    kubectl get nodes
                    echo "Listing all pods in all namespaces..."
                    kubectl get pods --all-namespaces
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Kubernetes is reachable from Jenkins!'
        }
        failure {
            echo '❌ Could not connect to Kubernetes. Check kubeconfig or network.'
        }
    }
}
