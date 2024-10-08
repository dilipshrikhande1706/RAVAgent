# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev build-essential curl && \
    rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container
COPY . .

# Install any needed Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Pull and install the llava:latest model (if needed)
RUN ollama pull llava:latest

# Expose the port Fly.io will use
EXPOSE 8080

# Command to run your RAVAgent Langflow app
CMD ["python", "run_RAVAgent.py"]
