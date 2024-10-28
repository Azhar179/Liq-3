# Use the Amazon Linux 2 base image
FROM amazonlinux:2

# Update the package list and install required packages
RUN yum update -y && \
    yum install -y curl tar gzip

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

# Set the MySQL JDBC driver version
ENV MYSQL_JDBC_VERSION=8.0.32

# Download the MySQL JDBC driver
RUN echo "Downloading MySQL JDBC Driver..." && \
    curl -L -O https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar && \
    mkdir -p /usr/local/bin/liquibase/lib && \
    mv mysql-connector-java-${MYSQL_JDBC_VERSION}.jar /usr/local/bin/liquibase/lib/

# Set the working directory
WORKDIR /usr/local/bin/liquibase

# Set the entrypoint to Liquibase
ENTRYPOINT ["liquibase"]
