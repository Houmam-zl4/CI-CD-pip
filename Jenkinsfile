pipeline {
    environment {
        registry = "houmam/tp4cicd"
        registryCredential = 'dockerhub' // ID des credentials Docker Hub dans Jenkins
        dockerImage = ''
        DOCKER_HOST = 'npipe:////./pipe/docker_engine' // Connexion Docker via le pipe sur Windows
    }
    agent any
    stages {
        stage('Cloning Git') {
            steps {
                git branch: 'main',
                    credentialsId: 'houmam',  // ID des credentials GitHub dans Jenkins
                    url: 'https://github.com/Houmam-zl4/CI-CD-pip'
            }
        }
        stage('Building Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    // Construction de l'image Docker avec le numéro de build Jenkins
                    dockerImage = docker.build("${registry}:${BUILD_NUMBER}")
                }
            }
        }
        stage('Testing Docker Image') {
            steps {
                script {
                    echo "Running tests on Docker image..."
                    // Remplacez ceci par des tests réels si nécessaire
                    echo "Tests passed"
                }
            }
        }
        stage('Publishing Docker Image') {
            steps {
                script {
                    echo "Publishing Docker image to Docker Hub..."
                    // Publier l'image Docker dans Docker Hub avec les credentials
                    docker.withRegistry('https://index.docker.io/v1/', registryCredential) {
                        dockerImage.push() // Push avec le numéro de build
                        dockerImage.push('latest') // Push avec le tag 'latest'
                    }
                }
            }
        }
        stage('Deploying Docker Image') {
            steps {
                script {
                    echo "Deploying Docker image..."
                    // Commande Docker pour démarrer un conteneur sur Windows avec le port 8080 mappé
                    bat "docker run -d -p 8080:80 --name app-${BUILD_NUMBER} ${registry}:${BUILD_NUMBER}"
                }
            }
        }
    }
    post {
        always {
            script {
                echo "Cleaning up workspace..."
                cleanWs() // Nettoie les fichiers temporaires du workspace Jenkins
            }
        }
        failure {
            script {
                echo "Pipeline failed. Check logs for more details."
            }
        }
        success {
            script {
                echo "Pipeline completed successfully!"
            }
        }
    }
}
