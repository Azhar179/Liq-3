# Base Liquibase image
FROM liquibase/liquibase:latest

# Install required packages
USER root  # Switch to root user to install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    unzip \                          # Required for extracting files
    curl \                           # Required for downloading files
    python3 \                       # Required to install pip
    python3-pip &&                  # Package manager for Python
    pip3 install awscli --upgrade  # Install AWS CLI

# Switch back to the liquibase user
USER liquibase

# Default command to run when the container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
