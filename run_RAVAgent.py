import subprocess
import time
import webbrowser
from pathlib import Path

# Step 1: Run Langflow in the background
langflow_process = subprocess.Popen(['langflow', 'run', '--backend-only'])

# Step 2: Wait for the Langflow backend to start (adjust time as needed)
time.sleep(10)  # Adjust this depending on how long Langflow takes to start

# Step 3: Open the HTML file
# Get the current folder
current_folder = Path().cwd()

# Create a relative path to the HTML file
html_file = current_folder / 'app' / 'chat_widget.html'

# Convert the path to a file URL
html_file_url = f'file://{html_file.resolve()}'
webbrowser.open(html_file_url)

# Optional: You can handle stopping the Langflow process if needed
# langflow_process.terminate()  # Uncomment to stop the Langflow process when done
