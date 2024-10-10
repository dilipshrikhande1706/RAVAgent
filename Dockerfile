# Use an official Python runtime as a parent image
FROM python:3.10-slim


# Set the working directory
WORKDIR /app


# Install system dependencies
RUN apt-get update && apt-get install -y \
   libpq-dev build-essential curl ca-certificates && \
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


# Expose the port Fly.io will use
EXPOSE 8080




# Command to run your RAVAgent Langflow app
CMD ["python", "run_RAVAgent.py"]