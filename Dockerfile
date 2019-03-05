FROM openjdk:8-jdk

ENV TERRAFORM_VER="0.11.7"

# Set up directories
RUN mkdir -p ~/.local/bin

# Install Docker
RUN apt-get update -y && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    apt-get update -y && \
    apt-get install -y docker-ce-cli

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Install AWS CLI
RUN apt-get install -y python-pip && \
    pip install awscli --upgrade --user

# Install Terraform
RUN mkdir -p ~/.local/bin && \
    cd ~/.local/bin && \
    curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip && \
    unzip *.zip && \
    rm *.zip && \
    chmod +x terraform
