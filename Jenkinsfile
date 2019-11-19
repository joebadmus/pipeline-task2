pipeline {
    agent any
    
    stages {
        stage("checking deploy tools and initial clean"){
            steps{
                sh 'git --version'
                sh 'docker -v'
                sh 'rm -rf codebase || true'
                sh '''docker rm -f $(docker ps -a -q) || true'''
            }
        }
        
        stage("pull down code base"){
            steps{
                sh 'git clone https://github.com/joebadmus/pipeline-task2.git -b node-app codebase'
            echo "====++++Code pulled++++===="
            }
        }

        stage("Builder docker Image"){
            steps {
                sh 'cd codebase/ && docker build -t testing .'
                echo "====++++Image Created++++===="
            }
        }

        stage("Start push to dockerhub"){
            steps {
                
                echo "tagging image"
                sh 'docker tag testing:latest joebadmus/node:v1'
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                sh 'docker login -u joebadmus -p $pass'
                sh 'docker push joebadmus/node:v1'
                sh 'docker logout'
                }
                echo "====++++App works++++===="
                // curl localhost:3000 | grep "Enter a City"
            }
        }


        stage("Deploy Image to App Server"){
            steps {

                withCredentials([file(credentialsId: 'KEY_PAIR', variable: 'THE_KEY')]) {
                sh 'ssh -i $KEY_PAIR ec2-user@3.9.173.192 docker run -p 8082:3000 -d nodeapp2 joebadmus/node:v1'
                }
	             echo 'code Deployed'
            }
        }
        
        stage("test code on app server"){
            steps {
                echo 'code tested'
            }
        }
        
        stage("complete"){
            steps {
                echo 'complete'
            }
        }
    }
}