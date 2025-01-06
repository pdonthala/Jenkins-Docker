pipeline {
    agent {
        docker {
            image 'maven:3.8.3-openjdk-17'  
            label 'docker-agent'
        }
    }
    environment {
        AZURE_CREDENTIALS = credentials('azure-service-principal')  // Azure Service Principal credentials (if deploying to Azure)
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the code from the repository...'
                checkout scm  // Checkout source code from GitHub repository
            }
        }
        stage('Build') {
            steps {
                echo 'Building the application using Maven...'
                sh 'mvn clean package'  // Run Maven to build the project
            }
        }
        stage('Run') {
            steps {
                echo 'Running the HelloWorld application...'
                sh 'java -cp target/hello-world-1.0-SNAPSHOT.jar com.example.HelloWorld'  // Run the HelloWorld class
            }
        }
        post {
            success {
                echo 'Build and execution successful!'
            }
            failure {
                echo 'Build or execution failed.'
            }
        }
    }
}
