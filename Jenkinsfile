pipeline {

    environment {
     webserver = "52.56.160.20"
     appserver = "3.10.233.75"
   }
    agent any

    stages {
         stage ('App server') {
              steps {
                    
                    sh 'rm -rf app-server || true'
                    sh 'git clone https://github.com/joebadmus/pipeline-task2.git -b app-server app-server'
                    echo '====++++App server setup complete++++===='
             }
         }

        stage ("Setup App server") {
            steps {
                    withCredentials([usernamePassword(credentialsId: 'AWS_DEV_SECRET', passwordVariable: 'my_aws_secret', usernameVariable: 'my_aws_key')]) {                    
                    sh  'cd app-server/infra/ && AWS_ACCESS_KEY_ID=$my_aws_key AWS_SECRET_ACCESS_KEY=$my_aws_secret terraform init'
                    }
                    echo '====++++Terraform successfully initiated++++===='
            }
        }

        stage ("Provision App Server") {
            steps {
                    withCredentials([usernamePassword(credentialsId: 'AWS_DEV_SECRET', passwordVariable: 'my_aws_secret', usernameVariable: 'my_aws_key')]) {
                    sh  'cd app-server/infra/ && AWS_ACCESS_KEY_ID=$my_aws_key AWS_SECRET_ACCESS_KEY=$my_aws_secret terraform apply --auto-approve'
                    }
                    echo '====++++App server setup complete++++===='
            }
        }

        stage ('Web server'){
             steps {
                    sh 'rm -rf web-server || true'
                    sh 'git clone https://github.com/joebadmus/pipeline-task2.git -b web-server web-server'
                    echo '====++++Web server setup complete++++===='
             }
         }

         stage ("Setup Web server") {
            steps {
                    withCredentials([usernamePassword(credentialsId: 'AWS_DEV_SECRET', passwordVariable: 'my_aws_secret', usernameVariable: 'my_aws_key')]) {                    
                    sh  'cd web-server/infra/ && AWS_ACCESS_KEY_ID=$my_aws_key AWS_SECRET_ACCESS_KEY=$my_aws_secret terraform init'
                    }
                    echo '====++++Web successfully initiated++++===='
            }
        }

        stage ("Provision Web Server") {
            steps {
                    withCredentials([usernamePassword(credentialsId: 'AWS_DEV_SECRET', passwordVariable: 'my_aws_secret', usernameVariable: 'my_aws_key')]) {
                    sh  'cd web-server/infra/ && AWS_ACCESS_KEY_ID=$my_aws_key AWS_SECRET_ACCESS_KEY=$my_aws_secret terraform apply --auto-approve'
                    }
                    echo '====++++Web server setup complete++++===='
            }
        }

        stage ('Configure paths') {
             steps {

                withCredentials([file(credentialsId: 'KEY_PAIR', variable: 'THE_KEY')]) {
                  sh 'cd config && scp -i  $THE_KEY -o StrictHostKeyChecking=no nginx.conf  ec2-user@${webserver}:/etc/nginx'
                }
	             echo 'code Deployed'
            }
        }

        stage ('Start Servers') {
             steps  {

                withCredentials([file(credentialsId: 'KEY_PAIR', variable: 'THE_KEY')]) {
                sh "ssh -i $THE_KEY -o StrictHostKeyChecking=no ec2-user@${webserver} 'sudo service nginx reload'"
                sh "ssh -i $THE_KEY -o StrictHostKeyChecking=no ec2-user@${appserver} 'cd /tmp/tomcat/apache-tomcat-8.5.47/bin/ && ./startup.sh'"
                }
                //   sh 'cd config && ./reload.sh'

                 echo 'complete'
                 }

        }
    }   
}