# Use a base image with the desired OS (e.g., Ubuntu, Debian, etc.)
FROM ubuntu:latest
# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server
# Create an SSH user
RUN useradd -rm -d /home/sshuser -s /bin/bash -g root -G sudo -u 1000 sshuser
RUN mkdir -p /home/sshuser/ftp
# Set the SSH user's password (replace "password" with your desired password)
RUN echo 'sshuser:password' | chpasswd
# Allow SSH access
RUN mkdir /var/run/sshd
# Expose the SSH port
EXPOSE 22
# Start SSH server on container startup
CMD ["/usr/sbin/sshd", "-D"]

# Docker build command to build the container
# docker build -t ssh_server .
# Docker run command to create a container
# docker run -d -p 2222:22 --name ssh_container -v ./ftp:/home/sshuser/ftp ssh_server