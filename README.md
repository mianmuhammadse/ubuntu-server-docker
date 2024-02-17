# Ubuntu Server Docker

Docker build command to build the container

`docker build -t ssh_server .`

Docker run command to create a container

`docker run -d -p 2222:22 --name ssh_container -v ./ftp:/home/sshuser/ftp ssh_server`

SSH into local ubuntu container

`ssh sshuser@localhost -p 2222`

Copying a local file to ssh container

`scp -P port_number /path/to/local/file username@remote_host:/path/to/destination/directory`
