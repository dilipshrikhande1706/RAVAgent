#!/bin/bash

# Start Ollama in the background and log output to a file
ollama start > ollama.log 2>&1 &

# Wait for Ollama to initialize
sleep 5

# Check if Ollama is running
if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:11434 | grep -q "200"; then
    echo "Failed to start Ollama."
    exit 1
fi

echo "Ollama is running."

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
