# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the MySQL JDBC Driver version
ENV MYSQL_JDBC_VERSION=8.0.32

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# Download the MySQL JDBC Driver
RUN curl -L -o /mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar

# Set the entrypoint
CMD ["bash"]
