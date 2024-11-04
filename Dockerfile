pipeline {
    agent any

    environment {
        // Define default values if needed
        DB_USERNAME = ''
        DB_PASSWORD = ''
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from Git
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'main'
            }
        }

        stage('Load Configuration') {
            steps {
                script {
                    // Load properties file
                    def props = readProperties file: 'config/database.properties'
                    
                    // Assign properties to environment variables
                    env.LIQUIBASE_HOME = props['LIQUIBASE_HOME']
                    env.DB_URL = props['DB_URL']
                    env.DB_DRIVER = props['DB_DRIVER']
                    env.CHANGELOG_FILE = props['CHANGELOG_FILE']
                }
            }
        }

        stage('Update Database') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'db-credential', usernameVariable: 'DB_USERNAME', passwordVariable: 'DB_PASSWORD')]) {
                    script {
                        // Run Liquibase update with parameters from properties file
                        bat """
                        cd ${env.LIQUIBASE_HOME}
                        liquibase --changeLogFile=${env.CHANGELOG_FILE} ^
                                  --url=${env.DB_URL} ^
                                  --username=${DB_USERNAME} ^
                                  --password=${DB_PASSWORD} ^
                                  --driver=${env.DB_DRIVER} update
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Liquibase update completed successfully.'
        }
        failure {
            echo 'Liquibase update failed.'
        }
    }
}
