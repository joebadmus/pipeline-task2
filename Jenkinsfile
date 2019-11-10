pipeline {
    agent any

    stages {
         stage ('Checking Deploy tool and initial cleanup') {
             steps {
                 sh 'mvn --version'
                 sh 'java -version'
                 sh 'nodejs -v || true' 
             }
         }

        stage ('complete') {
             steps  {
                 
                 echo  'complete'
            }
        }
    }
}