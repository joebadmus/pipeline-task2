pipeline {
    agent any

    stages {
         stage ('Checking Deploy tool and initial cleanup') {
             steps {
                 sh 'mvn --version'
                 sh 'java -version'
                 sh 'git --version' 
                 sh 'terraform -v'                 
             }
         }
         stage ('App server') {
                steps {
                    
                    sh 'rm -rf app-server || true'
                    //Git clone app 
                    sh 'git clone https://github.com/joebadmus/pipeline-task2.git -b app-server app-server'
                    //cd into the repo
                    sh 'cd app-server/infra'
                    sh 'terraform init && terraform apply --auto-approve'
                    //Initialize terraform
                    echo "====++++App server setup complete++++===="
                }
         }

        stage ('Web server'){
             steps {
                echo  'web server setup complete'
                //Git clone app 
                //cd into the repo
                //Initialize terraform
             }
         }
        stage ('complete') {
             steps  {
                 
                 echo  'complete'
            }
        }
    }
}