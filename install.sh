#!/bin/bash

# Function to check the distribution and install Docker and Docker Compose
install_docker() {
    if [ -f /etc/debian_version ]; then
        # Debian/Ubuntu-based system
        echo "Debian/Ubuntu system detected."
        
        # Update and install Docker
        sudo apt update -y
        sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt update -y
        sudo apt install docker-ce -y
        
        # Add user to Docker group
        sudo usermod -aG docker $USER
        sudo systemctl start docker
        sudo systemctl enable docker
        
    elif [ -f /etc/redhat-release ]; then
        # CentOS/Red Hat-based system
        echo "CentOS/RedHat system detected."
        
        # Update and install Docker
        sudo yum update -y
        sudo yum install docker -y
        
        # Add user to Docker group
        sudo usermod -aG docker ec2-user
        sudo service docker start
        sudo systemctl enable docker
        
    else
        echo "Unsupported Linux distribution. Exiting script."
        exit 1
    fi
}

# Function to change terminal color for user
change_terminal_color() {
    echo "Changing terminal color for the user..."
    if [ -f /home/$USER/.bash_profile ]; then
        echo "PS1='\e[1;32m\u@\h \w$ \e[m'" >> /home/$USER/.bash_profile
        source /home/$USER/.bash_profile
    fi
}

# Function to install Docker Compose
install_docker_compose() {
    echo "Installing Docker Compose..."

    # Get the latest version of Docker Compose
    latest_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | cut -d '"' -f 4)
    
    # Download Docker Compose binary
    sudo curl -L "https://github.com/docker/compose/releases/download/${latest_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    
    # Grant execute permissions
    sudo chmod +x /usr/local/bin/docker-compose
}

# Start installation process
install_docker
change_terminal_color
install_docker_compose

echo "Docker and Docker Compose installation complete!"
