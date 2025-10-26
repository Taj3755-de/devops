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
