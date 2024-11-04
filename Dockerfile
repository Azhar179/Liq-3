pipeline {
    agent {
        docker {
            image 'azhar179/my-new-image4'
            args '-u root'
        }
    }
    environment {
        DB_URL = 'jdbc:mysql://localhost:3306/pam-aurora-liquibase'
        DB_USERNAME = 'test'
        DB_PASSWORD = 'test'
        DB_DRIVER = 'com.mysql.cj.jdbc.Driver'
        LIQUIBASE_CLASSPATH = '/liquibase/lib/mysql-connector-j-9.0.0.jar'  // Explicit driver path
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'main'
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
