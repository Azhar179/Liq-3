pipeline {
    agent {
        docker {
            image 'azhar179/aws-image4'
            args '-u root'
        }
    }
    parameters {
        choice(name: 'databaseType', choices: ['MySQL', 'SQLServer'], description: 'Select the database to update')
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'master'
            }
        }
        stage('Load Configuration') {
            steps {
                script {
                    // Load properties based on the selected database type
                    def propsFile = params.databaseType == 'MySQL' ? 'config/mysql-database.properties' : 'config/sqlserver-database.properties'
                    def props = readProperties file: propsFile
                    
                    // Set environment variables from the properties file
                    env.DB_URL = props['DB_URL']
                    env.DB_USERNAME = props['DB_USERNAME']
                    env.DB_PASSWORD = props['DB_PASSWORD']
                    env.CHANGELOG_FILE = props['CHANGELOG_FILE']
                    
                    // Explicitly set the driver path
                    if (params.databaseType == 'MySQL') {
                        env.DB_DRIVER = '/liquibase/lib/mysql-connector-j-9.0.0.jar'
                    } else if (params.databaseType == 'SQLServer') {
                        env.DB_DRIVER = '/liquibase/lib/mssql-jdbc-11.2.1.jre8.jar'
                    }
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
