pipeline {
    agent {
        docker {
            image 'azhar179/da9b85fcc4b:latest'
            args '-u root'
        }
    }

    environment {
        DB_URL = 'jdbc:mysql://localhost:3306/twenty_eight'
        DB_USERNAME = 'root'
        DB_PASSWORD = 'root'
        DB_DRIVER = 'com.mysql.cj.jdbc.Driver'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3', branch: 'master'
            }
        }
        stage('Update Database') {
            steps {
                script {
                    def changelogFile = "src/main/resources/db/changelog/changelog-master.xml"
                    sh """
                    liquibase --changeLogFile=${changelogFile} \
                              --url=${DB_URL} \
                              --username=${DB_USERNAME} \
                              --password=${DB_PASSWORD} \
                              --driver=${DB_DRIVER} update
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
