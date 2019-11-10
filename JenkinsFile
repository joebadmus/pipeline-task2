pipeline {
    agent any

    stages {
         stage ('Checking Deploy tool and initial cleanup') {
             steps {
                 sh 'mvn --version'
                 sh 'java -version'
                 sh ' git --version'                 
             }
         }

        stage ('complete') {
             steps  {
                 echo  'complete'
            }
        }
    }
}