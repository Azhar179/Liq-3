# Base Liquibase image
FROM liquibase/liquibase:latest

# Set the Liquibase version
# ENV LIQUIBASE_VERSION=4.28.0

# Download and install the MySQL JDBC driver
RUN curl -L -o /liquibase/lib/mysql-connector-j-9.0.0.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.0.0/mysql-connector-j-9..0.jar

# Default command to run when container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
