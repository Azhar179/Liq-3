# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y curl tar gzip && \
    apt-get clean

# Set the Liquibase version
ENV LIQUIBASE_VERSION=4.28.0

# Download Liquibase
RUN echo "Downloading Liquibase..." && \
    curl -L -o liquibase-${LIQUIBASE_VERSION}.tar.gz https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Download complete. Checking file..." && \
    ls -l liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    if [ -f liquibase-${LIQUIBASE_VERSION}.tar.gz ]; then \
        echo "Extracting Liquibase..."; \
        tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz || (echo "Extraction failed"; exit 1); \
    else \
        echo "Download failed, file not found"; \
        exit 1; \
    fi && \
    mv liquibase-${LIQUIBASE_VERSION} liquibase && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz

# Download MySQL JDBC Driver
RUN echo "Downloading MySQL JDBC Driver..." && \
    curl -L -o /liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

# Set the entrypoint
CMD ["/bin/bash"]
