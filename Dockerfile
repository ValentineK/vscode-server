# Use code-server base image with configurable version
ARG CODE_SERVER_VERSION=4.104.0-bookworm
FROM codercom/code-server:${CODE_SERVER_VERSION}

# Switch to root for installations
USER root

# Install Node.js and npm
RUN apt-get update && apt-get install -y \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Claude CLI
RUN npm install -g @anthropic-ai/claude-code

# Switch back to the coder user
USER coder

# Expose VS Code Server port
EXPOSE 8080

# Start VS Code Server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]