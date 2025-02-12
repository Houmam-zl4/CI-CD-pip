pipeline {
    agent any

    stages {
        stage('Test Docker Build') {
            steps {
                script {
                    // Test si Dockerfile et index.html existent avant de construire l'image
                    if (fileExists('Dockerfile') && fileExists('CI-CD-pip/index.html')) {
                        echo "Dockerfile et index.html trouvés, démarrage de la construction..."
                        // Construire l'image Docker
                        sh 'docker build -t mon-projet-jenkins .'
                    } else {
                        error "Le Dockerfile ou index.html est manquant!"
                    }
                }
            }
        }
        stage('Test Docker Run') {
            steps {
                script {
                    // Exécuter le conteneur en mode détaché pour tester l'image
                    sh 'docker run -d -p 8081:80 --name mon-projet-jenkins mon-projet-jenkins'
                    // Vérifier si le conteneur fonctionne
                    sh 'docker ps -a'
                }
            }
        }
    }
}
