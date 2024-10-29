FROM ubuntu:latest

# Update packages and install dependencies
RUN apt-get update && \
    apt-get install -y curl tar gzip

# Set the Liquibase version
ENV LIQUIBASE_VERSION=4.28.0

# Download and install Liquibase
RUN curl -L -O https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz && \
    mv liquibase /usr/local/bin/ && \
    rm liquibase-${LIQUIBASE_VERSION}.tar.gz

# Ensure liquibase is on the PATH
ENV PATH="/usr/local/bin:$PATH"

# Download the MySQL JDBC Driver
RUN curl -L -o /liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

CMD ["/bin/bash"]
