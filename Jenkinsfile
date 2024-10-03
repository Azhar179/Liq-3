pipeline {
    agent any

    environment {
        LIQUIBASE_HOME = 'C:/liquibase'  // Path where Liquibase is installed
        DB_URL = 'jdbc:mysql://localhost:3306/twenty_nine'
        DB_USERNAME = 'root'
        DB_PASSWORD = 'root'
        DB_DRIVER = 'com.mysql.cj.jdbc.Driver'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liquibase_26.git', branch: 'master'
            }
        }
        stage('Update Database') {
            steps {
                script {
                    // Use the correct path to the changelog file
                     def changelogFile = "26-9/src/main/resources/db/changelog/changelog-master.xml"

                    bat """
                    cd ${LIQUIBASE_HOME}
                    liquibase --changeLogFile=${changelogFile} ^
                              --url=${DB_URL} ^
                              --username=${DB_USERNAME} ^
                              --password=${DB_PASSWORD} ^
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
