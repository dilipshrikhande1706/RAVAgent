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

# Start Langflow using environment variable for the port
LANGFLOW_PORT=7860

# Start Langflow in the foreground and allow its output to be printed in the terminal
langflow run --host 0.0.0.0 --port "$LANGFLOW_PORT" --backend-only | tee langflow.log &

# Wait for Langflow to start, increase the timeout to 30 seconds
max_langflow_attempts=15  # Maximum number of attempts to check Langflow's status
attempts=0
wait_time=2  # Wait 2 seconds between attempts

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

# Initialize variables for flow ID retrieval
max_flow_attempts=10  # Maximum number of attempts to retrieve flow_id
flow_attempts=0
wait_time=2           # Wait time between attempts in seconds

# Attempt to capture flow_id from Langflow
echo "Attempting to retrieve flow_id from Langflow..."

while true; do
    flow_id=$(curl -s -X GET http://0.0.0.0:"$LANGFLOW_PORT"/api/v1/flows | jq -r '.[0].id')

    # Check if flow_id is valid
    if [ -n "$flow_id" ] && [ "$flow_id" != "null" ]; then
        echo "Flow ID retrieved: $flow_id"
        break  # Exit the loop if flow_id is valid
    fi

    # Increment the attempt counter
    flow_attempts=$((flow_attempts + 1))

    # Check if the maximum attempts have been reached
    if [ "$flow_attempts" -ge "$max_flow_attempts" ]; then
        echo "Failed to retrieve flow_id from Langflow after $flow_attempts attempts."
        exit 1
    fi

    echo "Attempt $flow_attempts of $max_flow_attempts: flow_id is not valid. Retrying in $wait_time seconds..."
    sleep $wait_time  # Wait before the next attempt
done

# Update the HTML file with the retrieved flow_id
sed -i '' "s/FLOW_ID_PLACEHOLDER/$flow_id/g" chat_widget.html  # Adjust the `-i ''` for your OS if needed


# Open the chat widget HTML file in the default browser
# Comment out if running in a headless environment or do not want to open automatically
# open chat_widget.html

echo "Open the chat widget at: http://0.0.0.0:$LANGFLOW_PORT/chat_widget.html"  # Modify as needed

# Keep the container running
tail -f /dev/null
