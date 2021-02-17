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
        stage('init&plan') {
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
        // stage(apply){
        //     steps {
        //     dir('/var/jenkins_home/workspace/Terraform_main/terraform-dev-waf/compute') {
        //         sh'ls -la'
        //         withCredentials([[
        //         $class: 'AmazonWebServicesCredentialsBinding',
        //         credentialsId: credentialsId,
        //         accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        //         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        //     ]]) {
        //         sh 'terraform apply -var-file=dev.tfvars -auto-approve'
        //         }
        //     }
        //     }
        // }
        stage(show){
            steps{
            withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
            //ansiColor('xterm') {
                sh 'terraform show'
            }
        }
        }
        
    }    
}

//add tags

        