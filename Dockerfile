FROM maven:3.8.3-openjdk-17

# Install Docker CLI
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    lsb-release \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/trusted.gpg.d/docker.asc \
    && curl -fsSL https://download.docker.com/linux/debian/dists/stable/Release.gpg | tee /etc/apt/trusted.gpg.d/docker.asc \
    && curl -fsSL https://download.docker.com/linux/debian/dists/stable/main/binary-amd64/Packages | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce

# Install Azure CLI
RUN curl -sL https://aka.ms/azure-cli-archive-keyring | tee /usr/share/keyrings/azure-cli.asc
RUN echo "deb [signed-by=/usr/share/keyrings/azure-cli.asc] https://packages.microsoft.com/repos/azure-cli/ stable main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update && apt-get install -y azure-cli

# Set Docker group permissions for Jenkins user (optional)
RUN usermod -aG docker jenkins

# Set environment variable for the remote Docker host (Change the IP to match your Docker VM)
ENV DOCKER_HOST=tcp://<docker-vm-ip>:2375

# Set working directory for Jenkins (optional, based on your needs)
WORKDIR /workspace
