# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Update the package list and install required packages
RUN yum update -y && \
    yum install -y curl tar gzip

# Download and install Liquibase
RUN echo "Downloading Liquibase..." && \
    curl -L -O https://github.com/liquibase/liquibase/releases/download/v4.28.0/liquibase-4.28.0.tar.gz && \
    tar -xzf liquibase-4.28.0.tar.gz && \
    mv liquibase-4.28.0 /usr/local/bin/liquibase && \
    rm liquibase-4.28.0.tar.gz

# Create the lib directory for MySQL JDBC Driver
RUN mkdir -p /usr/local/bin/liquibase/lib

# Download MySQL JDBC Driver
RUN echo "Downloading MySQL JDBC Driver..." && \
    curl -L -o /usr/local/bin/liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

# Set the entrypoint
CMD ["/bin/bash"]
