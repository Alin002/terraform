// Jenkinsfile
String credentialsId = 'awsCredentials'

pipeline {
    agent any
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', credentialsId: 'b9502338-df40-4305-b77f-18bdb4d10ea0', url: 'https://github.com/Alin002/terraform.git'
                echo "pulled the code"
            }
            }
            }
        }


try {
    stage('checkout') {
        node {
        cleanWs()
        checkout scm
        }
    }

    // Run terraform init
    stage('init') {
        node {
        withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            ansiColor('xterm') {
            sh 'terraform init'
            }
        }
        }
    }

    // Run terraform plan
    stage('plan') {
        node {
        withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            ansiColor('xterm') {
            sh 'terraform plan -var-file=dev.tfvars'         
            }
            }
        }
        }

    if (env.BRANCH_NAME == 'main') {

        // Run terraform apply
        stage('apply') {
        node {
            withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
            ansiColor('xterm') {
                sh 'terraform apply -var-file=dev.tfvars -auto-approve'
            }
            }
        }
        }

        // Run terraform show
        stage('show') {
        node {
            withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
            ansiColor('xterm') {
                sh 'terraform show'
            }
            }
        }
        }
    }
    currentBuild.result = 'SUCCESS'
    }
    catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
    currentBuild.result = 'ABORTED'
    }
    catch (err) {
    currentBuild.result = 'FAILURE'
    throw err
    }
    finally {
    if (currentBuild.result == 'SUCCESS') {
        currentBuild.result = 'SUCCESS'
    }
}
    //     stage('Terraform Plan') {
    //     steps {
    //         sh "${env.TERRAFORM_HOME}/terraform plan -out=tfplan -input=false -var-file='dev.tfvars'"
    //     }
    //     }
    //     stage('Terraform Apply') {
    //     steps {
    //         input 'Apply Plan'
    //         sh "${env.TERRAFORM_HOME}/terraform apply -input=false tfplan"
    //     }
    //     }

