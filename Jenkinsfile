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
                // Vérifie si le fichier index.html est dans le répertoire du projet
                script {
                    if (fileExists('index.html')) {
                        echo "index.html trouvé"
                    } else {
                        error "Le fichier index.html est introuvable"
                    }
                }
                // Exemple de build Docker, construisez l'image à partir du Dockerfile
                sh 'docker build -f C:/Jenkins/jenkins11/Dockerfile -t mon-projet-jenkins .'
            }
        }
        stage('Test') {
            steps {
                // Exemple de tests : si vous avez des tests définis dans npm ou une autre configuration de test
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
