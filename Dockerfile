# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the Liquibase version and MySQL Connector version
ENV LIQUIBASE_VERSION=4.28.0
ENV MYSQL_CONNECTOR_VERSION=8.0.32

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y curl unzip && \
    apt-get clean

# Download and install Liquibase
RUN curl -L -O https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    mv liquibase-${LIQUIBASE_VERSION} liquibase && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz

# Download MySQL JDBC Driver
RUN curl -L -o /liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar

# Set the entrypoint
ENTRYPOINT ["liquibase"]

# Default command
CMD ["--help"]
