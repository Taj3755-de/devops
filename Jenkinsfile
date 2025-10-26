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
