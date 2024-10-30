# Base Liquibase image
FROM liquibase/liquibase:latest

# Download and install the MySQL JDBC driver
RUN curl -L -o /liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

# Default command to run when the container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
