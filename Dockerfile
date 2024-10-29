# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Update the package list and install required packages
RUN yum update -y && yum install -y curl tar gzip

# Set the entrypoint to start an interactive shell
CMD ["/bin/bash"]
