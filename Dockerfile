# Use an official Python runtime as a parent image
FROM --platform=linux/arm64 python:3.10-slim

# Set the working directory
WORKDIR /app

# Create the necessary directory for user installations and set permissions
RUN mkdir -p /root/.local/bin && chmod -R 777 /root/.local

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev build-essential curl procps && \
    rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container
COPY . .

# Upgrade pip
RUN pip install --upgrade pip

# Add the local bin to the PATH
ENV PATH="/root/.local/bin:$PATH"

# Install any needed Python packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Check installed Python packages (for debugging, can be commented out later)
RUN pip list

# Set Ollama host for local Mac access
ENV OLLAMA_HOST=http://host.docker.internal:11434

# Expose the port Fly.io will use
EXPOSE 8080

# Make sure the run.sh script is executable
RUN chmod +x run.sh

# Run the Langflow app
CMD ["./run.sh"]
