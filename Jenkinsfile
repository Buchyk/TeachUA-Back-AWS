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
            }
        }
         stage('Archive our project') { 
            steps {
                echo 'Archive our project'
                sh 'tar czf app-${BUILD_NUMBER}.tar.gz ${SOURCE_BACK_FILE}' 
            }
        }
        
         stage("Docker Login") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    
	         echo " ============== docker login =================="
                 sh 'docker login -u $USERNAME -p $PASSWORD'
                }
            }
        }
        stage('Build docker image for App') {
            steps{
                 echo " ============== docker build =================="
                 dockerImage = docker.build registry + ":$BUILD_NUMBER"
                 //sh 'docker build -t buchyk/backend:${params.TAG} .'
            }
        }
        stage("Docker Push") {
            steps {
                echo " ============== start pushing image =================="
                sh 'docker push buchyk/backend:${params.TAG}'
            }
        }
        
        // stage('Save build to archive') {
        //        steps {
        //          sshPublisher(
        //             continueOnError: false, failOnError: true,
        //                publishers: [
        //                sshPublisherDesc(
        //                    configName: "${DESTINATION_SERVER}",
        //                  verbose: true,
        //                    transfers: [
        //                      sshTransfer(
        //                      sourceFiles: "app-${BUILD_NUMBER}.tar.gz",
        //                          remoteDirectory: "${SAVE_ARCHIVE_BACK}",
        //                  )
        //              ])
        //          ])
        //      }
        //  }
        // stage('SSH transfer') {
        //        steps {
        //          sshPublisher(
        //             continueOnError: false, failOnError: true,
        //                publishers: [
        //                sshPublisherDesc(
        //                    configName: "${DESTINATION_SERVER}",
        //                  verbose: true,
        //                    transfers: [
        //                      sshTransfer(
        //                          sourceFiles: "${SOURCE_BACK_FILE}",
        //                          removePrefix: "${BACK_PREFICS}",
        //                          remoteDirectory: "${REMOTE_WEBDIR_BACK}",
        //                          execCommand: "sudo mv ${RENAME_FROM}  ${RENAME_TO}"
        //                 )
        //            ])
        //        ])
        //      }
        // }
     }
 }
