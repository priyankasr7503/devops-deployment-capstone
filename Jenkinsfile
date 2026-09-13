pipeline {
    agent any

    environment {
        DOCKER_USER = 'priyarchandra'
        IMAGE_NAME = 'react-devops-app'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_USER%/%IMAGE_NAME%:%BUILD_NUMBER% .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        bat 'docker tag %DOCKER_USER%/%IMAGE_NAME%:%BUILD_NUMBER% %DOCKER_USER%/dev:%BUILD_NUMBER%'
                        bat 'docker push %DOCKER_USER%/dev:%BUILD_NUMBER%'
                    }
                    else if (env.BRANCH_NAME == 'master') {
                        bat 'docker tag %DOCKER_USER%/%IMAGE_NAME%:%BUILD_NUMBER% %DOCKER_USER%/prod:%BUILD_NUMBER%'
                        bat 'docker push %DOCKER_USER%/prod:%BUILD_NUMBER%'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}
