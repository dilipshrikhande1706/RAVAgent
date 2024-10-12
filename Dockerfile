# Use an official Python runtime as a parent image
FROM --platform=linux/arm64 python:3.10-slim

# Set the working directory
WORKDIR /app

# Install system dependencies including procps for ps command
RUN apt-get update && apt-get install -y \
    libpq-dev build-essential curl procps && \
    rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container
COPY . .

# Upgrade pip
RUN pip install --upgrade pip

# Install Ollama
RUN pip install --no-cache-dir ollama

# Install any needed Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Set Ollama host for local Mac access
ENV OLLAMA_HOST=http://host.docker.internal:11434

# Expose the port Fly.io will use
EXPOSE 8080

# Run the Langflow app
CMD ["./run.sh"]
