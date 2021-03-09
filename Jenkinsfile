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
        
        
        stage('Save build to archive') {
               steps {
                 sshPublisher(
                    continueOnError: false, failOnError: true,
                       publishers: [
                       sshPublisherDesc(
                           configName: "${DESTINATION_SERVER}",
                         verbose: true,
                           transfers: [
                             sshTransfer(
                             sourceFiles: "app-${BUILD_NUMBER}.tar.gz",
                                 remoteDirectory: "${SAVE_ARCHIVE_BACK}",
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
                           configName: "${DESTINATION_SERVER}",
                         verbose: true,
                           transfers: [
                             sshTransfer(
                                 sourceFiles: "${SOURCE_BACK_FILE}",
                                 removePrefix: "${BACK_PREFICS}",
                                 remoteDirectory: "${REMOTE_WEBDIR_BACK}",
                                 execCommand: "sudo mv ${RENAME_FROM}  ${RENAME_TO}"
                        )
                   ])
               ])
             }
        }
     }
 }
