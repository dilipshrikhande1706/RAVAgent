# Use an official Python runtime as a parent image for linux/amd64 to ensure compatibility
FROM --platform=linux/amd64 python:3.10-slim

# Set the working directory
WORKDIR /app

# Install system dependencies, including procps for the `ps` command
RUN apt-get update && apt-get install -y \
   libpq-dev build-essential curl ca-certificates procps && \
   rm -rf /var/lib/apt/lists/*

# Install Ollama CLI
RUN curl -fsSL https://ollama.com/install.sh | sh

# Copy the Ollama startup script
COPY ollama_start.sh ./ollama_start.sh
RUN chmod +x ./ollama_start.sh

# Start the Ollama service and pull the llava:latest model
RUN ./ollama_start.sh

# Copy the current directory contents into the container
COPY . .

# Install any needed Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Make sure the run.sh script is executable
RUN chmod +x ./run.sh

# Expose the port Fly.io will use
EXPOSE 8080

# Command to run your RAVAgent Langflow app using run.sh
CMD ["./run.sh"]
