#!/bin/bash

# Install Ollama CLI if not already installed
if ! command -v ollama &> /dev/null
then
    echo "Ollama CLI not found, installing..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# Start the Ollama service
echo "Starting Ollama service..."
ollama serve &

# Pull the llava:latest model
echo "Pulling llava:latest model..."
ollama pull llava:latest

echo "Ollama service is running with llava:latest model."
