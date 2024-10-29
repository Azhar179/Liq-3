# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package list and install curl
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# Set the Liquibase version
ENV LIQUIBASE_VERSION=4.28.0

# Download Liquibase
RUN echo "Downloading Liquibase..." && \
    curl -L -O https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Download complete. Checking file..." && \
    ls -l liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Extracting Liquibase..." && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    mv liquibase-${LIQUIBASE_VERSION} liquibase && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz

# Set the entrypoint
ENTRYPOINT ["liquibase"]

# Default command
CMD ["--help"]
