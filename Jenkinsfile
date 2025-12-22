pipeline {
    agent any
    tools {
     maven 'maven'
    }
    stages {
        stage('build the war file')
        {
            steps{
                 sh 'cp ./target/hello-wildfly-1.0.war ./backub'
                 sh 'mvn clean pacKage'

            }
        }

        stage('build docker image & bush to dockerhub'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub',passwordVariable: 'PASS',userVariable:'USER')]){
                    sh """
                       echo $PASS | docker login -u $USER --password-stdin 
                       docker rmi abdo133/java-web-app:v01 || true 
                       docker build -t abdo133/java-web-app:v01 .
                       docker push abdo133/java-web-app:v01

                    """
                }
            }
        }

        stage('deploy the application'){
            steps{
                sh 'docker run -d -p 8080:8081 -p 9990:9990 abdo133/java-web-app:v01'
            }
        }
    }
}
