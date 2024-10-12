#!/bin/bash

# Start Ollama in the background and log output to a file
ollama start > ollama.log 2>&1 &

# PID of the last background process (Ollama)
OLLAMA_PID=$!

# Function to check if Ollama is running
is_ollama_running() {
    # Check if the Ollama process is running by its PID
    if ps -p $OLLAMA_PID > /dev/null; then
        return 0 # Ollama is running
    else
        return 1 # Ollama is not running
    fi
}

# Wait until Ollama is running
while ! is_ollama_running; do
    echo "Waiting for Ollama to start..."
    sleep 1
done

echo "Ollama is running with PID: $OLLAMA_PID"

# Start Langflow in the background
langflow > /dev/null 2>&1 &

# Wait for Langflow to start
sleep 10

# Capture flow_id from Langflow and insert it into the HTML file
flow_id=$(curl -X GET http://localhost:7860/api/flows | jq -r '.[0].id')
sed -i '' "s/FLOW_ID_PLACEHOLDER/$flow_id/g" chat_widget.html

# Open the chat widget HTML file in the default browser
open chat_widget.html

# Keep the container running
tail -f /dev/null
