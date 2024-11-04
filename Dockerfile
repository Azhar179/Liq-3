pipeline {
    agent {
        docker {
            image 'azhar179/custom-image'
            args '-u root'
        }
    }
    environment {
        // Retrieve the values from Jenkins secrets
        DB_USERNAME = credentials('db-username') // Assuming 'db-username' is the ID of your Jenkins secret
        DB_PASSWORD = credentials('db-password') // Assuming 'db-password' is the ID of your Jenkins secret
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'master'
            }
        }
        stage('Load Database Properties') {
            steps {
                script {
                    // Load properties from the file
                    def props = readProperties file: 'config/database.properties'
                    env.DB_URL = props.DB_URL
                    env.DB_DRIVER = props.DB_DRIVER
                    env.LIQUIBASE_HOME = props.LIQUIBASE_HOME
                    env.CHANGELOG_FILE = props.CHANGELOG_FILE
                }
            }
        }
        stage('Update Database') {
            steps {
                script {
                    sh """
                    liquibase --changeLogFile=${env.CHANGELOG_FILE} \
                              --url=${env.DB_URL} \
                              --username=${DB_USERNAME} \
                              --password=${DB_PASSWORD} \
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
