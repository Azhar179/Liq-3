# Base Liquibase image
FROM liquibase/liquibase:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y unzip curl python3-pip && \
    pip3 install awscli --upgrade

# Download and install the MySQL JDBC driver
RUN curl -L -o /liquibase/lib/mysql-connector-j-9.0.0.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.0.0/mysql-connector-j-9.0.0.jar

# Default command to run when container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
