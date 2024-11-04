pipeline {
    agent {
        docker {
            image 'azhar179/my-new-image4'
            args '-u root'
        }
    }
    environment {
        // Default values; these will be overridden after reading the properties file
        DB_URL = ''
        DB_USERNAME = 'test' // Hardcoded for now
        DB_PASSWORD = 'test'  // Hardcoded for now
        DB_DRIVER = '' // Will be read from properties file
        LIQUIBASE_HOME = '/liquibase' // Update this if necessary for the Docker image
        LIQUIBASE_CLASSPATH = '/liquibase/lib/mysql-connector-j-9.0.0.jar'  // Explicit driver path
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'main'
            }
        }
        stage('Load Database Properties') {
            steps {
                script {
                    // Read properties file
                    def props = readProperties file: 'config/database.properties'
                    
                    // Assign properties to environment variables
                    env.DB_URL = props.DB_URL
                    env.DB_DRIVER = props.DB_DRIVER
                }
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
