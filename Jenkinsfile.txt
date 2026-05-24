pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/priyankasr7503/devops-deployment-capstone.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t react-devops-app .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat 'docker run -d -p 3000:80 react-devops-app'
            }
        }
    }
}