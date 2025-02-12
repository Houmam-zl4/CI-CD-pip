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
                // Exemple de build Docker, construisez l'image à partir du Dockerfile
                sh 'docker build -t mon-projet-jenkins .'
            }
        }
        stage('Test') {
            steps {
                // Exemple de tests : si vous avez des tests définis dans npm ou une autre configuration de test
                // Modifiez cette ligne en fonction de votre environnement et des tests que vous souhaitez exécuter
                sh 'docker run --rm mon-projet-jenkins npm test'
            }
        }
        stage('Deploy') {
            steps {
                // Déploiement avec le conteneur mon-projet-jenkins
                sh 'docker run -d -p 8081:80 --name mon-projet-jenkins mon-projet-jenkins'
            }
        }
    }
}
