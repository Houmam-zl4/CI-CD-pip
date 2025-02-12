pipeline {
    agent any

    environment {
        NODE_HOME = 'C:\\Program Files\\nodejs'
        PATH = "${NODE_HOME};${env.PATH}" // Ajoute Node.js au PATH si non reconnu
    }

    stages {
        stage('Cloner le dépôt') {
            steps {
                script {
                    // Si le dépôt est privé, ajouter les credentials Jenkins
                    git branch: 'main', credentialsId: 'GITHUB_CREDENTIALS', url: 'https://github.com/Houmam-zl4/jenkins11.git'
                }
            }
        }

        stage('Installer les dépendances') {
            steps {
                script {
                    def installStatus = bat(script: 'npm install', returnStatus: true)
                    if (installStatus != 0) {
                        error("❌ Erreur: npm install a échoué !")
                    }
                }
            }
        }

        stage('Tester le projet') {
            steps {
                script {
                    def testStatus = bat(script: 'npm test', returnStatus: true)
                    if (testStatus != 0) {
                        currentBuild.result = 'FAILURE'
                        error("❌ Les tests ont échoué !")
                    }
                }
            }
        }

        stage('Archiver les tests') {
            steps {
                archiveArtifacts artifacts: '**/test-results/**/*.xml', allowEmptyArchive: true
            }
        }

        stage('Déployer') {
            when {
                branch 'main'
            }
            steps {
                script {
                    def deployStatus = bat(script: 'npm run deploy', returnStatus: true)
                    if (deployStatus != 0) {
                        error("❌ Le déploiement a échoué !")
                    }
                }
            }
        }
    }

    post {
        always {
            echo '📝 Pipeline terminé.'
        }
        failure {
            echo '❌ Échec du pipeline !'
        }
    }
}
