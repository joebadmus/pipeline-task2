pipeline {
    agent any
    
    stages {
        stage("checking deploy tools and initial clean"){
            steps{
                sh 'git --version'
                sh 'docker -v'
                sh 'rm -rf codebase || true'
                sh 'docker rm -f $(docker ps -a -q)'
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

        stage("Start container"){
            steps {
                sh '''
                docker run -p  3000:3000 -d testing
                '''
                echo "====++++App works++++===="
                // curl localhost:3000 | grep "Enter a City"

            }
        }


        // stage("Deploy Image to ECS"){
        //     steps {

        //         // withCredentials([file(credentialsId: 'KEY_PAIR', variable: 'THE_KEY')]) {
        //         // sh 'docker push 735287868690.dkr.ecr.eu-west-2.amazonaws.com/jideweatherapp:latest'
        //         // }
	    //          echo 'code Deployed'
        //     }
        // }
        
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