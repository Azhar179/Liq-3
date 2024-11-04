
pipeline {
    agent {
        docker {
            image 'azhar179/eds-image5'
            args '-u root'
        }
    }
    environment {
        DB_URL = "jdbc:sqlserver://dbs-db.usr.test.pib.sql.io;database=Archive;encrypt=true;trustServerCertificate=true"
        DB_USERNAME = 'test'
        DB_PASSWORD = 'test'
        DB_DRIVER = 'com.microsoft.sqlserver.jdbc.SQLServerDrive'
        LIQUIBASE_CLASSPATH = '/liquibase/lib/mssql-jdbc-11.2.1.jre8.jar'  // Explicit driver path
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
