pipeline {
    agent {
        docker {
            image 'maven:3.8.3-openjdk-17'  
            label 'docker-agent'
        }
    }
    environment {
        AZURE_CREDENTIALS = credentials('azure_service_principal') // Add Azure SP creds in Jenkins
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building application...'
                sh 'mvn clean package'
            }
        }
        stage('Deploy to Azure Static Web Apps') {
            steps {
                script {
                    sh """
                    az login --service-principal -u ${AZURE_CREDENTIALS_USR} \
                    -p ${AZURE_CREDENTIALS_PSW} --tenant <tenant-id>
                    az staticwebapp upload --name <app-name> \
                    --resource-group <resource-group> --source ./target
                    """
                }
            }
        }
    }
}
