pipeline {
    agent {
        docker {
            image 'maven:3.8.3-openjdk-17'  
            label 'docker'
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
                    -p ${AZURE_CREDENTIALS_PSW} --tenant "56359ef4-08c1-491c-b0fd-135bce685d00"
                    az staticwebapp upload --name "jenkinsdock234-ahgtcwaubdaehygp.canadacentral-01.azurewebsites.net" \
                    --resource-group "LinuxVM" --source ./target
                    """
                }
            }
        }
    }
}
