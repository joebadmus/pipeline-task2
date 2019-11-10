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

        stage ('complete') {
             steps  {
                 
                 echo  'complete'
            }
        }
    }
}