pipeline {
    agent any 
    stages {
        stage('Compile and Clean') { 
            steps {
                // Run Maven on a Unix agent.
              
                sh "mvn clean compile"
            }
        }
        stage('deploy') { 
            
            steps {
                sh "mvn package"
            }
        }
        stage('Build Docker image'){
          
            steps {
            
                sh 'ls'
                sh 'docker build -t  vivek87/apolis-demo:${BUILD_NUMBER} .'
            }
        }
        stage('Docker Login'){
            
            steps {
                 withCredentials([string(credentialsId: 'DockerId', variable: 'Dockerpwd')]) {
                    sh "docker login -u vivek87 -p ${Dockerpwd}"
                }
            }                
        }
        stage('Docker Push'){
            steps {
                sh 'docker push vivek87/apolis-demo:${BUILD_NUMBER}'
            }
        }
        stage('Docker deploy'){
            steps {
               
                sh 'docker run -itd -p  8081:8080 vivek87/apolis-demo:${BUILD_NUMBER}'
            }
        }
        stage('Archving') { 
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
    }
}

