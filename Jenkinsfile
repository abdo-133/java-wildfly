pipeline {
    agent any
    tools {
        
     maven 'maven'
    }
    stages {
        stage('build the war file')
        {
            steps{
                
             sh """
                 mvn clean package
                 mkdir -p backup || true
                 cp target/hello-wildfly-1.0.war backup
                """

            }
        }

        stage('build docker image & push to dockerhub'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub',passwordVariable: 'PASS',usernameVariable:'USER')]){
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
             sh """
                docker stop hello-java ||true
                docker rm hello-java || true
                docker run -d -p 8081:8080 -p 9990:9990 --name hello-java abdo133/java-web-app:v01
                """
            }
        }
    }
}
