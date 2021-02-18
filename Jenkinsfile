String credentialsId = 'awsCredentials'

// def tfCmd(String command, String options = '') {
// 	ACCESS = "export AWS_PROFILE=${PROFILE} && export TF_ENV_profile=${PROFILE}"
// 	sh ("cd $WORKSPACE/main && ${ACCESS} && terraform init") // main
// 	sh ("cd $WORKSPACE/main && terraform workspace select ${ENV_NAME} || terraform workspace new ${ENV_NAME}")
// 	sh ("echo ${command} ${options}") 
//         sh ("cd $WORKSPACE/main && ${ACCESS} && terraform init && terraform ${command} ${options} && terraform show -no-color > show-${ENV_NAME}.txt")
// }

pipeline {
    agent any

    // parameters {

	// 	string (name: 'ENV_NAME',
    //             defaultValue: 'DEV',
    //             description: 'Env name')
	// 	choice (name: 'ACTION',
	// 			choices: [ 'plan', 'apply', 'destroy'],
	// 			description: 'Run terraform plan / apply / destroy')
    // }

    stages {
        stage('checkout') {
            steps {
            cleanWs()
            checkout scm
            }
        }

        stage('init&plan') {
            when { anyOf
                            {
                                environment name: 'ACTION', value: 'plan';
                                environment name: 'ENV_NAME', value: 'DEV'
                            }
            }
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
                        sh 'terraform  plan -var-file=dev.tfvars ' 
                        }
                    }
            }
            }
        
    stage(apply){
            when { anyOf
					{
						environment name: 'ACTION', value: 'apply'
					}
				}
        steps {
                dir('/var/jenkins_home/workspace/Terraform_main/terraform-dev-waf/compute') {
                    sh'ls -la'
                    withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: credentialsId,
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh 'terraform apply -var-file=dev.tfvars -auto-approve'
                    }
                }
                }
        }

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
        
        


    stage(destroy){
            when { anyOf
					{
						environment name: 'ACTION', value: 'destroy'
					}
            }
        steps {
                dir('/var/jenkins_home/workspace/Terraform_main/terraform-dev-waf/compute') {
                    sh'ls -la'
                    withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: credentialsId,
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh 'terraform destroy -var-file=dev.tfvars -auto-approve'
                    }
                }
                }
        }
    }
}       