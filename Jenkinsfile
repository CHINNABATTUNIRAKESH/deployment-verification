pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = 'true'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/CHINNABATTUNIRAKESH/deployment-verification'
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init'

            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([string(credentialsId: 'aws-key-name', variable: 'KEY_NAME')]) {
                    bat"terraform apply -auto-approve -var 'key_name=${KEY_NAME}' tfplan"
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    def public_ip = sh(script: "terraform output -raw public_ip", returnStdout: true).trim()
                    def status = sh(script: "curl -sf http://${public_ip}/health", returnStatus: true)
                    if (status != 0) {
                        error("Health check failed at http://${public_ip}/health")
                    } else {
                        echo "Health check passed at http://${public_ip}/health"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment verified successfully!"
        }
        failure {
            echo "❌ Something went wrong. Check the logs!"
        }
    }
}
