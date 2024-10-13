#!/bin/bash

# Start Ollama in the background and log output to a file
# ollama start > ollama.log 2>&1 &

# Wait for Ollama to initialize (increase the sleep duration)
sleep 2000

# Check if Ollama is running
if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:11434 | grep -q "200"; then
    echo "Failed to start Ollama."
    exit 1
fi

echo "Ollama is running."

# Start Langflow and allow its output to be printed in the terminal
langflow | tee langflow.log &  # Use tee to also save to a log file

# Wait for Langflow to start
sleep 10

# Check if Langflow is running
if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:7860 | grep -q "200"; then
    echo "Failed to start Langflow."
    exit 1
fi

echo "Langflow is running."

# Capture flow_id from Langflow and insert it into the HTML file
flow_id=$(curl -X GET http://localhost:7860/api/flows | jq -r '.[0].id')

# Check if flow_id is valid
if [ -z "$flow_id" ]; then
    echo "Failed to retrieve flow_id from Langflow."
    exit 1
fi

sed -i '' "s/FLOW_ID_PLACEHOLDER/$flow_id/g" chat_widget.html

# Open the chat widget HTML file in the default browser
# Remove or comment this line:
# open chat_widget.html
echo "Open the chat widget at: http://localhost:7860/chat_widget.html"  # Modify as needed

# Keep the container running
tail -f /dev/null
