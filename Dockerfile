# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Set environment variables
ENV LIQUIBASE_VERSION=4.28.0

# Install necessary packages and Liquibase
RUN yum update -y && \
    yum install -y wget && \
    wget https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    mv liquibase-${LIQUIBASE_VERSION} liquibase && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz

# Set the working directory
WORKDIR /liquibase

# Command to run liquibase (optional, modify as needed)
ENTRYPOINT ["liquibase"]
