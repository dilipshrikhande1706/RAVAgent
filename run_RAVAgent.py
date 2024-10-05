import subprocess
import time
import webbrowser

# Step 1: Run Langflow in the background
langflow_process = subprocess.Popen(['langflow', 'run', '--backend-only'])

# Step 2: Wait for the Langflow backend to start (adjust time as needed)
time.sleep(10)  # Adjust this depending on how long Langflow takes to start

# Step 3: Open the HTML file
html_file = 'file:///Users/dilipshrikhande/PycharmProjects/RAVAgent/app/chat_widget.html'
webbrowser.open(html_file)

# Optional: You can handle stopping the Langflow process if needed
# langflow_process.terminate()  # Uncomment to stop the Langflow process when done
