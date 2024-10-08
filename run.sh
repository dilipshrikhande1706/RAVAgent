#!/bin/bash

# Start ollama in the background
ollama start > /dev/null 2>&1 &

# PID of the last background process (ollama start)
OLLAMA_PID=$!

# Function to check if ollama is running (customize this to your needs)
is_ollama_running() {
    # Check if the ollama process is running by its PID
    if ps -p $OLLAMA_PID > /dev/null; then
        return 0 # true, ollama is running
    else
        return 1 # false, ollama is not running
    fi
}

# Wait until ollama is running
while ! is_ollama_running; do
    echo "Waiting for Ollama to start..."
    sleep 1
done

echo "Ollama is running with PID: $OLLAMA_PID"

python3 run_RAVAgent.py

exit