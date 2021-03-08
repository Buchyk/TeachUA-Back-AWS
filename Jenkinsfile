pipeline {
    options { timestamps() }
    agent {
        docker {
            image 'maven:3-openjdk-8'
            args '-v /root/.m2:/root/.m2' 
        }
    }
   
    stages {
        stage('Test') { 
            steps {
                echo 'Running automation test'
                sh 'mvn test'
            }
        }
        stage('Build') { 
            steps {
                echo 'Running build automation'
                sh 'mvn clean package'
                sh 'tar czf app-${BUILD_NUMBER}.tar.gz target/*.war' 
            }
        }
         stage('Archive our project') { 
            steps {
                echo 'Archive our project'
                sh 'tar czf app-${BUILD_NUMBER}.tar.gz target/*.war' 
            }
        }
        
        
        stage('Save build to archive') {
               steps {
                 sshPublisher(
                    continueOnError: false, failOnError: true,
                       publishers: [
                       sshPublisherDesc(
                        configName: "ec2-user@3.64.250.181",
                         verbose: true,
                           transfers: [
                             sshTransfer(
                             sourceFiles: "app-${BUILD_NUMBER}.tar.gz",
                               remoteDirectory: "/home/ec2-user/mount/back",
                         )
                     ])
                 ])
             }
         }
        stage('SSH transfer') {
               steps {
                 sshPublisher(
                    continueOnError: false, failOnError: true,
                       publishers: [
                       sshPublisherDesc(
                        configName: "ec2-user@3.64.250.181",
                         verbose: true,
                           transfers: [
                             sshTransfer(
                             sourceFiles: "target/*.war",
                               removePrefix: "target/",
                               remoteDirectory: "/home/ec2-user/teachua/www/back",
                               execCommand: "sudo mv /home/ec2-user/teachua/www/back/TeachUA-1.0.war  /home/ec2-user/teachua/www/back/dev.war"
                        )
                   ])
               ])
             }
        }
     }
 }
