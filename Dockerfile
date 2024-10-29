# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Update the package list and install required packages
RUN yum update -y && \
    yum install -y curl tar gzip && \
    sleep 2  # Adding a short pause after updating

# Set the Liquibase version
ENV LIQUIBASE_VERSION=4.28.0

# Download Liquibase
RUN echo "Downloading Liquibase..." && \
    curl -L -O https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    echo "Extracting Liquibase..." && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    mv liquibase-${LIQUIBASE_VERSION} liquibase && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz

# Download MySQL JDBC Driver
RUN curl -L -o /usr/local/bin/liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

# Set the entrypoint to /bin/bash
CMD ["/bin/bash"]
