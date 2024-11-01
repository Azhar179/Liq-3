pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/my-liquibase-image-driver'
        DB_URL = 'jdbc:mysql://localhost:3306/twenty_eight'
        DB_USERNAME = 'root'
        DB_PASSWORD = 'root'
        DB_DRIVER = 'com.mysql.cj.jdbc.Driver'
        LIQUIBASE_CLASSPATH = '/liquibase/lib/mysql-connector-j-9.0.0.jar'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Azhar179/Liq-3.git', branch: 'master'
            }
        }
        stage('Run Liquibase in Docker') {
            steps {
                script {
                    def changelogFile = "src/main/resources/db/changelog/changelog-master.xml"
                    bat """
                    docker run --rm -v %WORKSPACE%:/workspace -w /workspace ^
                    -e DB_URL=%DB_URL% ^
                    -e DB_USERNAME=%DB_USERNAME% ^
                    -e DB_PASSWORD=%DB_PASSWORD% ^
                    -e LIQUIBASE_CLASSPATH=%LIQUIBASE_CLASSPATH% ^
                    %DOCKER_IMAGE% liquibase ^
                    --changeLogFile=%WORKSPACE%\\${changelogFile} ^
                    --url=%DB_URL% ^
                    --username=%DB_USERNAME% ^
                    --password=%DB_PASSWORD% ^
                    --driver=%DB_DRIVER% update
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
