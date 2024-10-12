
# Use an official Python runtime as a parent image
FROM --platform=linux/arm64 python:3.10-slim

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev build-essential curl procps && \
    rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container
COPY . .

# Upgrade pip
RUN pip install --upgrade pip

# Add Ollama to the PATH
ENV PATH="/root/.local/bin:$PATH"

# Check installed Python packages (for debugging)
RUN pip list

# Install any needed Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Fly.io will use
EXPOSE 8080

# Make sure the run.sh script is executable
RUN chmod +x run.sh

# Run the Langflow app
CMD ["./run.sh"]
