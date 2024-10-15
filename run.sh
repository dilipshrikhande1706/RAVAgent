#!/bin/bash

# Start Ollama in the background
ollama serve > ollama.log 2>&1 &

# Wait for Ollama to initialize
max_attempts=30
wait_time=5
attempts=0

echo "Waiting for Ollama to start..."

# Loop to check if Ollama is running
until curl -s -o /dev/null -w "%{http_code}" http://ravagent-ollama:11434 | grep -q "200"; do
    attempts=$((attempts + 1))
    if [ "$attempts" -ge "$max_attempts" ]; then
        echo "Failed to start Ollama after $attempts attempts."
        exit 1
    fi
    echo "Ollama is not yet running. Attempt $attempts of $max_attempts. Retrying in $wait_time seconds..."
    sleep $wait_time
done

echo "Ollama is running."

# Get the container ID of the Ollama service
ollama_container_id=$(docker ps -q -f "ancestor=ollama/ollama:latest")

# Pull the 'nomic-embed-text' model inside the Ollama container
echo "Pulling 'nomic-embed-text' model in the Ollama container..."
docker exec "$ollama_container_id" ollama pull nomic-embed-text

# Verify if the model was pulled successfully
if [ $? -ne 0 ]; then
    echo "Failed to pull 'nomic-embed-text' model."
    exit 1
else
    echo "'nomic-embed-text' model pulled successfully."
fi

# Pull the 'llama3.1' model inside the Ollama container
echo "Pulling 'llama3.1' model in the Ollama container..."
docker exec "$ollama_container_id" ollama pull llama3.1

# Verify if the model was pulled successfully
if [ $? -ne 0 ]; then
    echo "Failed to pull 'llama3.1' model."
    exit 1
else
    echo "'llama3.1' model pulled successfully."
fi

# Start Langflow using environment variable for the port
LANGFLOW_PORT=7860

# Start Langflow in the foreground and allow its output to be printed in the terminal
langflow run --host 0.0.0.0 --port "$LANGFLOW_PORT" --backend-only | tee langflow.log &

# Wait for Langflow to start
max_langflow_attempts=15
attempts=0
wait_time=2

echo "Waiting for Langflow to start..."

until curl -s -o /dev/null -w "%{http_code}" http://0.0.0.0:"$LANGFLOW_PORT"/health | grep -q "200"; do
    attempts=$((attempts + 1))
    if [ "$attempts" -ge "$max_langflow_attempts" ]; then
        echo "Failed to start Langflow after $attempts attempts."
        exit 1
    fi
    echo "Langflow is not yet running. Attempt $attempts of $max_langflow_attempts. Retrying in $wait_time seconds..."
    sleep $wait_time
done

echo "Langflow is running."

# Run the RAVAgent script
python3 run_RAVAgent.py

echo "Open the chat widget at: http://0.0.0.0:$LANGFLOW_PORT/chat_widget.html"

# Keep the container running
tail -f /dev/null
