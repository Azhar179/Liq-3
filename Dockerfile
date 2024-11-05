pipeline {
    agent {
        docker {
            image 'azhar1/my-new-image4'
            args '-u root'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'main'
            }
        }
        stage('Load Configuration') {
            steps {
                script {
                    // Load properties from the config file
                    def props = readProperties file: 'config/database.properties'
                    
                    // Set environment variables from properties
                    env.DB_URL = props['DB_URL']
                    env.DB_DRIVER = props['DB_DRIVER']
                    env.DB_USERNAME = props['DB_USERNAME']
                    env.DB_PASSWORD = props['DB_PASSWORD']
                    env.CHANGELOG_FILE = props['CHANGELOG_FILE']
                }
            }
        }
        stage('Update Database') {
            steps {
                script {
                    sh """
                    liquibase --changeLogFile=${env.CHANGELOG_FILE} \
                              --url=${env.DB_URL} \
                              --username=${env.DB_USERNAME} \
                              --password=${env.DB_PASSWORD} \
                              --driver=${env.DB_DRIVER} update
                    """
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
