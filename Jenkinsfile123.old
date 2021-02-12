// Jenkinsfile
String credentialsId = 'awsCredentials'
env.jenkins_node_custom_workspace_path = '/var/jenkins_home/${JOB_NAME}/workspace/terraform-dev-waf/compute'

try {
    stage('checkout') {
        node {
        cleanWs()
        checkout scm
        }
    }

    stage('clone repo') {
            node {
                git branch: 'main', credentialsId: 'b9502338-df40-4305-b77f-18bdb4d10ea0', url: 'https://github.com/Alin002/terraform.git'
                echo "pulled the code"
            }
            }

    // Run terraform init
    stage('init') {

        dir ("/var/jenkins_home/workspace/Terraform_main/terraform-dev-waf/compute") {
            sh "pwd"
        }

        node {
        withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            ansiColor('xterm') {
            sh 'sudo terraform init $jenkins_node_custom_workspace_path/terraform-dev-waf/compute'
            sh 'sudo terraform plan $jenkins_node_custom_workspace_path/terraform-dev-waf/compute -var-file=dev.tfvars' 
            }
        }
        }
    }

    // Run terraform plan
    // stage('plan') {
    //     node {
    //     withCredentials([[
    //         $class: 'AmazonWebServicesCredentialsBinding',
    //         credentialsId: credentialsId,
    //         accessKeyVariable: 'AWS_ACCESS_KEY_ID',
    //         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
    //     ]]) {
    //         ansiColor('xterm') {
    //         sh 'terraform plan -var-file=dev.tfvars'         
    //         }
    //         }
    //     }
    //     }

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

