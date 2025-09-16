# Use code-server base image with configurable version
ARG CODE_SERVER_VERSION=4.104.0-bookworm
FROM codercom/code-server:${CODE_SERVER_VERSION}

# Install Node.js and npm
RUN sudo apt-get update && sudo apt-get install -y \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash - \
    && sudo apt-get install -y nodejs \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*

# Install Claude CLI
RUN sudo npm install -g @anthropic-ai/claude-cli

# Expose VS Code Server port
EXPOSE 8080

# Start VS Code Server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]