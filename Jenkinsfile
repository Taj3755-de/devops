pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Taj3755-de/devops.git', credentialsId: 'kube-jenkins'
            }
        }

        stage('Terraform Security Check') {
            steps {
                dir('terraform-sample') {
                    echo "Initializing Terraform..."
                    sh 'terraform init'
                    echo "Validating Terraform configuration..."
                    sh 'terraform validate'
                    echo "Running tfsec scan..."
                    sh '/usr/local/bin/tfsec --severity CRITICAL,HIGH --no-color || exit 1'
                    echo "Documenting tfsec scan results..."
                    sh '''
                    mkdir -p security-docs
                    echo "tfsec scan executed on $(date)" > security-docs/terraform-security-report.txt
                    /usr/local/bin/tfsec --format json >> security-docs/terraform-security-report.txt || true
                    '''
                }
            }
        }
    }
}
