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
            echo "Running tfsec scan..."
            sh '''
            /usr/local/bin/tfsec --format json --out tfsec-report.json || true

            # Count high and critical issues
            HIGH_COUNT=$(jq '[.results[] | select(.severity=="HIGH" or .severity=="CRITICAL")] | length' tfsec-report.json)
            MEDIUM_COUNT=$(jq '[.results[] | select(.severity=="MEDIUM")] | length' tfsec-report.json)
            LOW_COUNT=$(jq '[.results[] | select(.severity=="LOW")] | length' tfsec-report.json)

            echo "High/Critical issues: $HIGH_COUNT"
            echo "Medium issues: $MEDIUM_COUNT"
            echo "Low issues: $LOW_COUNT"

            # Fail pipeline if high/critical issues exist
            if [ "$HIGH_COUNT" -gt 0 ]; then
                echo "❌ HIGH or CRITICAL tfsec issues found!"
                cat tfsec-report.json | jq '.results[] | select(.severity=="HIGH" or .severity=="CRITICAL")'
                exit 1
            fi

            # Optional: log medium/low for documentation
            if [ "$MEDIUM_COUNT" -gt 0 ]; then
                echo "⚠️ Medium tfsec issues (can be reviewed for future fixes):"
                cat tfsec-report.json | jq '.results[] | select(.severity=="MEDIUM")'
            fi

            if [ "$LOW_COUNT" -gt 0 ]; then
                echo "ℹ️ Low tfsec issues (informational):"
                cat tfsec-report.json | jq '.results[] | select(.severity=="LOW")'
            fi
            '''
        }
    }
}
    }
}
