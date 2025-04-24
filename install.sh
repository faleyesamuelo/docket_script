#!/bin/bash
# docker install
sudo yum update -y
sudo yum install docker -y
sudo usermod -aG docker ec2-user
sudo service docker start
sudo systemctl enable docker 
# Change terminal color for user ec2-user
echo "PS1='\e[1;32m\u@\h \w$ \e[m'" >> /home/ec2-user/.bash_profile
#install git
sudo yum install git -y
# install wget
sudo yum install wget -y

# Install docker compose

# Get the latest version number of Docker Compose from GitHub
latest_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | cut -d '"' -f 4)

# Download Docker Compose binary
sudo curl -L "https://github.com/docker/compose/releases/download/${latest_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# grant permissions
sudo chmod +x /usr/local/bin/docker-compose
