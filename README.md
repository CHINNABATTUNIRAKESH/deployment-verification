# Deploy Nginx with Jenkins & Terraform

This project provisions an AWS EC2 instance running Nginx using Terraform, and automates deployment with Jenkins. A health check is done post-deployment.

## Files
- `main.tf` - AWS EC2 + Security Group
- `variables.tf` - Key pair input
- `outputs.tf` - Output public IP
- `Jenkinsfile` - Jenkins CI/CD pipeline

## Setup Steps
1. Create AWS EC2 Key Pair
2. Add Jenkins credentials (type: string) with ID `aws-key-name`
3. Connect GitHub repo to Jenkins
4. Trigger the Jenkins pipeline

## Health Check
Runs curl on: `http://<deployed-ec2-ip>/health`