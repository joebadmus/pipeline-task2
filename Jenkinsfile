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
                    sh 'cd app-server && cd infra'
                    // sh 'terraform init && terraform apply --auto-approve'
                    //Initialize terraform
                    echo '====++++App server setup complete++++===='
             }
         }

         stage ("Setup App server") {
            steps {
                    sh 'pwd && ls -la'
                    withCredentials([usernamePassword(credentialsId: 'AWS_DEV_SECRET', passwordVariable: 'my_aws_secret', usernameVariable: 'my_aws_key')]) {
                    sh  'AWS_ACCESS_KEY_ID=$my_aws_key AWS_SECRET_ACCESS_KEY=$my_aws_secret terraform init'
                    echo '====++++Terraform successfully initiated++++===='
            }
        }

        stage ("Provision App Server") {
            steps {
                    withCredentials([usernamePassword(credentialsId: 'AWS_DEV_SECRET', passwordVariable: 'my_aws_secret', usernameVariable: 'my_aws_key')]) {
                    sh  'AWS_ACCESS_KEY_ID=$my_aws_key AWS_SECRET_ACCESS_KEY=$my_aws_secret terraform apply --auto-approve'
                    echo '====++++pp server setup complete++++===='
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