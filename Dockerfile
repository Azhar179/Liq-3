# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y curl

# Create the liquibase directory and lib directory
RUN mkdir -p /liquibase/lib

# Download MySQL JDBC Driver
RUN curl -L -o /liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

# Set the entrypoint
CMD ["/bin/bash"]
