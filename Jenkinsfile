pipeline {
    agent any 
    stages {
        stage('Compile and Clean') { 
            steps {
                // Run Maven on a Unix agent.
              
                sh "mvn clean"
            }
        }
        stage('deploy') { 
            
            steps {
                sh "mvn install"
            }
        }
        stage('Build Docker image'){
          
            steps {
                echo "Hello Java Express"
                sh 'ls'
                sh 'docker build -t  vivek87/apolis-demo:${BUILD_NUMBER} .'
            }
        }
        stage('DockerLogin'){
            
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
            def dockerrun='docker run -itd -p  8081:8080 vivek87/apolis-demo:${BUILD_NUMBER}'
            steps {
                
                sshagent(['production-server']) {
                    
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.85.132 ${dockerrun}'
                }
               
               // sh 'docker run -itd -p  8081:8080 vivek87/apolis-demo:${BUILD_NUMBER}'
            }
        }
        stage('Archving') { 
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
    }
}

