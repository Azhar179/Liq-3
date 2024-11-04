# Base Liquibase image
FROM liquibase/liquibase:latest

# Install required packages including AWS CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        unzip \                        # Required for extracting files
        curl \                         # Required for downloading files
        python3 \                     # Required to install pip
        python3-pip &&                # Package manager for Python
    pip3 install --no-cache-dir awscli &&  # Install AWS CLI using pip
    apt-get remove --purge -y python3-pip &&  # Remove pip to reduce image size
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*  # Clean up the apt cache

# Download and install the MySQL JDBC driver
RUN curl -L -o /liquibase/lib/mysql-connector-j-9.0.0.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.0.0/mysql-connector-j-9.0.0.jar

# Default command to run when container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
