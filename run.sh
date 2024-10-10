#!/bin/bash

# Start Ollama in the background
ollama start > /dev/null 2>&1 &

# PID of the last background process (ollama start)
OLLAMA_PID=$!

# Function to check if Ollama is running by sending a health check request
is_ollama_running() {
    if curl -s http://localhost:11434/health | grep -q "healthy"; then
        return 0 # true, Ollama is running
    else
        return 1 # false, Ollama is not running
    fi
}

# Wait until Ollama is running
while ! is_ollama_running; do
    echo "Waiting for Ollama to start..."
    sleep 1
done

echo "Ollama is running with PID: $OLLAMA_PID"

# Run your Python script
python3 run_RAVAgent.py

exit
