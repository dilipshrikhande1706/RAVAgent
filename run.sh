#!/bin/bash

# Start Ollama in the background and log output to a file
# Uncomment the following line if needed
# ollama start > ollama.log 2>&1 &

# Wait for Ollama to initialize
max_attempts=30  # Maximum number of attempts
wait_time=2      # Wait time between attempts in seconds
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

# Start Langflow in the foreground and allow its output to be printed in the terminal
langflow -p 7860 | tee langflow.log

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

# Update the HTML file with the retrieved flow_id
sed -i '' "s/FLOW_ID_PLACEHOLDER/$flow_id/g" chat_widget.html  # Adjust based on your system

# Open the chat widget HTML file in the default browser
# Comment out if running in a headless environment or do not want to open automatically
# open chat_widget.html

echo "Open the chat widget at: http://localhost:7860/chat_widget.html"  # Modify as needed

# Keep the container running
tail -f /dev/null
