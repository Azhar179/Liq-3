# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Set environment variables
ENV LIQUIBASE_VERSION=4.28.0

# Install necessary packages, including gzip, and Liquibase
RUN yum update -y && \
    yum install -y curl tar gzip && \
    echo "Downloading Liquibase..." && \
    curl -L -O https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Extracting Liquibase..." && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    mv liquibase-${LIQUIBASE_VERSION} liquibase && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Liquibase installed successfully."

# Set the working directory
WORKDIR /liquibase

# Command to run liquibase (optional, modify as needed)
ENTRYPOINT ["liquibase"]
