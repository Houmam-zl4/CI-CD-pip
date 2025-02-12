pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Récupère le code source du dépôt Git
                git branch: 'main', url: 'https://github.com/Houmam-zl4/CI-CD-pip.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Vérifie si Dockerfile existe avant de procéder au build
                    if (fileExists('C:/Jenkins/jenkins11/Dockerfile')) {
                        sh 'docker build -f C:/Jenkins/jenkins11/Dockerfile -t mon-projet-jenkins .'
                    } else {
                        error 'Dockerfile is missing!'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Tester l'image construite (ajuster cette ligne en fonction de ton environnement de test)
                    try {
                        sh 'docker run --rm mon-projet-jenkins npm test'
                    } catch (Exception e) {
                        echo "Tests failed: ${e.getMessage()}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Déployer l'image Docker dans un conteneur
                sh 'docker run -d -p 8081:80 --name mon-projet-jenkins mon-projet-jenkins'
            }
        }
    }

    post {
        always {
            // Nettoyer après le pipeline : arrêter et supprimer le conteneur s'il est encore en cours d'exécution
            sh 'docker stop mon-projet-jenkins || true'
            sh 'docker rm mon-projet-jenkins || true'
        }
    }
}
