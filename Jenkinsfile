pipeline {
        agent any

        stages {
            stage('mkdir') {
                steps {
                sh'mkdir ios && touch ios/HelloWorld.txt'  
                }
            }
            stage('test') {
                steps {
                dir('ios') {
                    sh'ls -la'
                }
                }
            }
        }
}