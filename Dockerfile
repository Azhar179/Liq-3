# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Update and install required packages
RUN yum update -y && \
    yum install -y curl tar gzip && \
    echo "Installed curl, tar, and gzip successfully."

# Set Liquibase version
ENV LIQUIBASE_VERSION=4.28.0

# Download Liquibase tarball
RUN echo "Downloading Liquibase..." && \
    curl -L -o liquibase-${LIQUIBASE_VERSION}.tar.gz https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Download complete: liquibase-${LIQUIBASE_VERSION}.tar.gz" && \
    ls -l liquibase-${LIQUIBASE_VERSION}.tar.gz

# Extract Liquibase and move it to /usr/local/bin
RUN echo "Extracting Liquibase..." && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Extraction complete" && \
    ls -l liquibase-${LIQUIBASE_VERSION} && \
    mv liquibase-${LIQUIBASE_VERSION} /usr/local/bin/liquibase && \
    chmod +x /usr/local/bin/liquibase && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Liquibase installed successfully."

# Create the lib directory for MySQL JDBC Driver
RUN mkdir -p /usr/local/bin/liquibase/lib

# Download MySQL JDBC Driver
RUN echo "Downloading MySQL JDBC Driver..." && \
    curl -L -o /usr/local/bin/liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar && \
    echo "MySQL JDBC Driver downloaded successfully."

# Set the entrypoint
CMD ["/bin/bash"]
