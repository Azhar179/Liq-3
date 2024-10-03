pipeline {
    agent any

    environment {
        LIQUIBASE_HOME = 'C:/liquibase'  // Path where Liquibase is installed
        DB_URL = 'jdbc:mysql://localhost:3306/twenty_eight'
        DB_DRIVER = 'com.mysql.cj.jdbc.Driver'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'master'
            }
        }
        stage('Update Database') {
            steps {
                // Use Jenkins credentials to inject the database username and password
                withCredentials([usernamePassword(credentialsId: 'db-credentials', usernameVariable: 'DB_USERNAME', passwordVariable: 'DB_PASSWORD')]) {
                    script {
                        // Use the correct path to the changelog file
                        def changelogFile = "03-10/src/main/resources/db/changelog/changelog-master.xml"

                        // Run Liquibase update
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
