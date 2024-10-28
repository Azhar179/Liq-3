#!/bin/bash

# Update the package list and install required packages
yum update -y
yum install -y curl tar gzip

# Set the Liquibase version
LIQUIBASE_VERSION=4.28.0

# Download Liquibase
echo "Downloading Liquibase..."
curl -L -O https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz

# Extract Liquibase
echo "Extracting Liquibase..."
tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz

# Move Liquibase to /usr/local/bin
mv liquibase-${LIQUIBASE_VERSION} liquibase
mv liquibase /usr/local/bin/

# Clean up
rm liquibase-${LIQUIBASE_VERSION}.tar.gz

echo "Liquibase version ${LIQUIBASE_VERSION} installed successfully."
