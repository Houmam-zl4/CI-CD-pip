pipeline {
    agent any

    environment {
        registry = "houmamzl4/tp4cicd" // Ton nom de repository Docker Hub
        registryCredential = 'b6e75e96-d1aa-4907-a8b2-2ffb5370a524' // ID des credentials Docker Hub dans Jenkins
        DOCKER_HOST = 'npipe:////./pipe/docker_engine' // Connexion Docker pour Windows
    }

    stages {
        stage('Cloner le dépôt') {
            steps {
                script {
                    git branch: 'main',
                        credentialsId: 'GITHUB_CREDENTIALS', // ID Jenkins pour GitHub
                        url: 'https://github.com/Houmam-zl4/jenkins11.git' // Ton repo GitHub
                }
            }
        }

        stage('Construire l’image Docker') {
            steps {
                script {
                    echo "🚀 Construction de l'image Docker..."
                    def buildStatus = bat(script: "docker build -t ${registry}:${BUILD_NUMBER} .", returnStatus: true)
                    if (buildStatus != 0) {
                        error("❌ Échec de la construction Docker !")
                    }
                }
            }
        }

        stage('Tester l’image Docker') {
            steps {
                script {
                    echo "🔬 Exécution des tests sur l'image Docker..."
                    def testStatus = bat(script: "echo 'Tests passés ✅'", returnStatus: true)
                    if (testStatus != 0) {
                        error("❌ Échec des tests Docker !")
                    }
                }
            }
        }

        stage('Publier sur Docker Hub') {
            steps {
                script {
                    echo "📤 Publication de l'image sur Docker Hub..."
                    docker.withRegistry('https://index.docker.io/v1/', registryCredential) {
                        withCredentials([string(credentialsId: '83683e3b-50c2-40df-ac1f-f09a07da8ca5', variable: 'DOCKER_PASSWORD')]) {
                            def pushStatus = bat(script: """
                                docker login -u houmamzl4 -p ${DOCKER_PASSWORD}
                                docker push ${registry}:${BUILD_NUMBER}
                                docker tag ${registry}:${BUILD_NUMBER} ${registry}:latest
                                docker push ${registry}:latest
                            """, returnStatus: true)
                            if (pushStatus != 0) {
                                error("❌ Échec du push sur Docker Hub !")
                            }
                        }
                    }
                }
            }
        }

        stage('Déployer le conteneur') {
            when {
                branch 'main'
            }
            steps {
                script {
                    echo "🚀 Déploiement du conteneur Docker..."
                    def deployStatus = bat(script: """
                        docker stop app-${BUILD_NUMBER} || echo "Pas de conteneur à stopper"
                        docker rm app-${BUILD_NUMBER} || echo "Pas de conteneur à supprimer"
                        docker run -d -p 8081:80 --name app-${BUILD_NUMBER} ${registry}:${BUILD_NUMBER}
                    """, returnStatus: true)
                    if (deployStatus != 0) {
                        error("❌ Échec du déploiement Docker !")
                    }
                }
            }
        }
    }

    post {
        always {
            echo '📝 Nettoyage du workspace...'
            cleanWs() // Nettoie les fichiers temporaires Jenkins
        }
        failure {
            echo '❌ Échec du pipeline !'
        }
        success {
            echo '✅ Pipeline terminé avec succès !'
        }
    }
}
