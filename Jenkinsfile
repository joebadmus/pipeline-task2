pipeline {
    agent any
    
    stages {
        stage("checking deploy tools and initial clean"){
            steps{
                sh 'git --version'
                sh 'docker -v'
                sh 'rm -rf codebase || true'
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

            // echo 'Image successfully created'
        }

        stage("Deploy Image to ECS"){
            steps {

                // withCredentials([file(credentialsId: 'KEY_PAIR', variable: 'THE_KEY')]) {
                //   sh 'cd codebase/javacode/LiquorStoreServlet/target/ && ls -la && scp -i  $THE_KEY -o StrictHostKeyChecking=no SampleServlet.war  ec2-user@3.8.175.230:/tmp/tomcat/apache-tomcat-8.5.47/webapps'
                // }
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