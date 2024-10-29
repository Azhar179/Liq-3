# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y curl

# Set the MySQL Connector/J version
ENV MYSQL_CONNECTOR_VERSION=8.0.32

# Download MySQL JDBC Driver
RUN curl -L -o /mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar

# Set the entrypoint
CMD ["/bin/bash"]
