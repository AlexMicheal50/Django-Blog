pipeline {
    agent {
        docker {
            image 'python:3.8'
        }
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Install dependencies
                    sh 'pip install -r requirements.txt'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests
                    sh 'python manage.py test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with timestamp
                    def timestamp = new Date().format("yyyyMMdd-HHmmss")
                    sh "docker build -t your-django-app:${timestamp} ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // SSH into the deployment server and deploy the Dockerized app
                    sshagent(['your-ssh-credentials-id']) {
                        sh 'ssh user@your-deployment-server "docker stop your-django-app || true"'
                        sh 'ssh user@your-deployment-server "docker rm your-django-app || true"'
                        sh 'ssh user@your-deployment-server "docker pull your-django-app:${timestamp}"'
                        sh 'ssh user@your-deployment-server "docker run -d --name your-django-app -p 8000:8000 your-django-app:${timestamp}"'
                    }
                }
            }
        }
    }
}
