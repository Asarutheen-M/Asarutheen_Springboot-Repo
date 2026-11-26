// Triggered by GitHub webhook (enable "GitHub hook trigger for GITScm polling" on the job)
pipeline {
    agent any
    tools { maven 'maven3'; jdk 'jdk17' }   // configure these names in Jenkins > Tools
    environment {
        AWS_REGION = 'ap-south-1'
        ECR_REPO   = 'hdfc-app'
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Maven Build & Test') {
            steps { sh 'mvn clean package' }
        }
        stage('Terraform (ECR + EKS)') {
            steps {
                dir('terraform') {
                    sh 'terraform init -input=false'
                    sh 'terraform apply -auto-approve -input=false'
                }
            }
        }
        stage('Ansible (Docker build, push to ECR, deploy)') {
            steps {
                sh "ansible-playbook -i ansible/inventory.ini ansible/playbook.yml -e image_tag=${IMAGE_TAG} -e aws_region=${AWS_REGION}"
            }
        }
    }
    post {
        failure {
            mail to: 'admin@example.com',
                 subject: "Build FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Check ${env.BUILD_URL}"
        }
    }
}
