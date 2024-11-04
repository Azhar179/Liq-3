pipeline {
    agent {
        docker {
            image 'your-dockerhub-username/my-liquibase-image-driver'
            args '-u root'
        }
    }

    environment {
        SECRET_NAME = "your-secret-name" // Update with your actual secret name in AWS Secrets Manager
        REGION = "us-west-2" // Specify your AWS region
        LIQUIBASE_CLASSPATH = '/liquibase/lib/mysql-connector-j-9.0.0.jar'
    }

    stages {
        stage('Fetch Database Credentials') {
            steps {
                script {
                    def secretJSON = sh(script: "aws secretsmanager get-secret-value --secret-id ${SECRET_NAME} --region ${REGION} --query SecretString --output text", returnStdout: true).trim()
                    def secret = readJSON text: secretJSON
                    env.DB_URL = secret.DB_URL
                    env.DB_USERNAME = secret.DB_USERNAME
                    env.DB_PASSWORD = secret.DB_PASSWORD
                }
            }
        }

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
                              --url=${env.DB_URL} \
                              --username=${env.DB_USERNAME} \
                              --password=${env.DB_PASSWORD} \
                              --driver=com.mysql.cj.jdbc.Driver update
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
