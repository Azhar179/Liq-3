pipeline {
    agent {
        docker {
            image 'your-dockerhub-username/eds-image'
            args '-u root'
            command 'liquibase'
        }
    }
    environment {
        DB_URL = 'jdbc:sqlserver://localhost:1433;databaseName=your_database'
        DB_USERNAME = 'your_username'
        DB_PASSWORD = 'your_password'
        DB_DRIVER = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
        LIQUIBASE_CLASSPATH = '/liquibase/lib/mssql-jdbc-11.2.1.jre8.jar' // Updated path
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'master'
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
