# Use a base image with the desired OS (e.g., Ubuntu, Debian, etc.)
FROM ubuntu:latest

# Install SSH server and vsftpd FTP server
RUN apt-get update && \
    apt-get install -y openssh-server vsftpd

# Create an SSH user
RUN useradd -rm -d /home/sshuser -s /bin/bash -g root -G sudo -u 1000 sshuser
RUN mkdir -p /home/sshuser/ftp

# Set the SSH user's password (replace "password" with your desired password)
RUN echo 'sshuser:password' | chpasswd

# Configure vsftpd for the SSH user
RUN echo "local_enable=YES" >> /etc/vsftpd.conf && \
    echo "write_enable=YES" >> /etc/vsftpd.conf && \
    echo "chroot_local_user=YES" >> /etc/vsftpd.conf && \
    echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf && \
    echo "user_sub_token=$USER" >> /etc/vsftpd.conf && \
    echo "local_root=/home/$USER/ftp" >> /etc/vsftpd.conf

# Allow SSH access
RUN mkdir /var/run/sshd

# Expose the SSH and FTP ports
EXPOSE 22
EXPOSE 21

# Start SSH server and vsftpd on container startup
CMD ["/usr/sbin/sshd", "-D"]
