String credentialsId = 'awsCredentials'
pipeline {
        agent any

        stages {
            stage('checkout') {
                steps {
                cleanWs()
                checkout scm
                }
            }
            stage('init') {
                steps {
                dir('/var/jenkins_home/workspace/Terraform_main/terraform-dev-waf/compute') {
                    sh'ls -la'
                    withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: credentialsId,
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh 'terraform init'
                    sh 'terraform  plan -var-file=dev.tfvars' 
                        }
                        }
            }
        }
    }
}