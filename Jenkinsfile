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
                sh 'rm testing.tar || true'
                sh 'docker save testing:latest > testing.tar'
                sh "scp -i $THE_KEY -o StrictHostKeyChecking=no testing.tar ec2-user@3.9.173.192:/tmp"
                }
	             echo 'code Deployed'
            }
        }
        
        stage("Run App in App Server"){
            steps {

                withCredentials([file(credentialsId: 'KEY_PAIR', variable: 'THE_KEY')]) {
                sh "ssh -i $THE_KEY -o StrictHostKeyChecking=no ec2-user@3.9.173.192 'docker load < /tmp/testing.tar'"
                sh "ssh -i $THE_KEY -o StrictHostKeyChecking=no ec2-user@3.9.173.192 'docker run -p 8082:3000 -d --name nodeapp testing:latest'"
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