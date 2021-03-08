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
     }
 }
