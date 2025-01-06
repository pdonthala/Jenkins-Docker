pipeline {
    agent {
        docker {
            image 'alpine'
            label 'docker'
        }
    }
    environment {
        AZURE_CREDENTIALS = credentials('azure_service_principal') // Add Azure SP creds in Jenkins
    }
    stages {
         stage('Setup Environment') {
            steps {
                script {
                    echo 'Installing Maven, Azure CLI, and dependencies...'
                    sh '''
                    sudo apt-get update
                    sudo apt-get install -y openjdk-17-jdk maven apt-transport-https ca-certificates curl software-properties-common
                    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                    '''
                }
            }
        }       
        stage('Checkout') {
            steps {
                checkout scm
            }
        }        
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
                    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                    apt-get update && apt-get install -y azure-cli
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
