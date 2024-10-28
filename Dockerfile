# Use an official Java runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Install Liquibase
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/liquibase/liquibase/releases/download/v4.28.0/liquibase-4.28.0.tar.gz && \
    tar -xzf liquibase-4.28.0.tar.gz && \
    mv liquibase-4.28.0 liquibase && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-4.28.0.tar.gz

# Copy MySQL JDBC driver to Liquibase lib directory
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar -P /usr/local/bin/liquibase/lib/

# Set the command to run when starting the container
CMD ["liquibase", "--changeLogFile=src/main/resources/db/changelog/changelog-master.xml", "update"]
