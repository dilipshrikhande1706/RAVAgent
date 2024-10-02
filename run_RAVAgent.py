import subprocess
import time
import webbrowser
from pathlib import Path
import json

# Function to get flow_id from the JSON file
def get_flow_id(json_file_path):
    try:
        # Open and read the JSON file
        with open(json_file_path, 'r') as f:
            flow_data = json.load(f)

        # Extract and return the flow_id
        flow_id = flow_data.get('id', None)
        if flow_id:
            print(f"Flow ID: {flow_id}")
        else:
            print("Flow ID not found in the JSON file.")
        return flow_id

    except FileNotFoundError:
        print(f"Error: The file {json_file_path} was not found.")
        return None
    except json.JSONDecodeError:
        print("Error: Could not decode the JSON file.")
        return None

# Function to inject the flow_id as a global JavaScript variable and create a temporary HTML file
def inject_flow_id_to_html(html_file_path, flow_id):
    try:
        # Read the original HTML file content
        with open(html_file_path, 'r') as f:
            html_content = f.read()

        # Inject flow_id as a global JavaScript variable
        injected_script = f'<script>window.flowId = "{flow_id}";</script>'
        modified_html_content = html_content.replace(
            '<script src="https://cdn.jsdelivr.net/gh/logspace-ai/langflow-embedded-chat@v1.0.6/dist/build/static/js/bundle.min.js"></script>',
            f'<script src="https://cdn.jsdelivr.net/gh/logspace-ai/langflow-embedded-chat@v1.0.6/dist/build/static/js/bundle.min.js"></script>{injected_script}'
        )

        # Save the modified HTML content to a temporary file
        temp_html_file = html_file_path.with_name('chat_widget_temp.html')
        with open(temp_html_file, 'w') as f:
            f.write(modified_html_content)

        print(f"Temporary HTML file created at {temp_html_file}")
        return temp_html_file

    except FileNotFoundError:
        print(f"Error: The file {html_file_path} was not found.")
        return None
    except Exception as e:
        print(f"An error occurred while modifying the HTML file: {e}")
        return None

# Step 1: Run Langflow in the background
langflow_process = subprocess.Popen(['langflow', 'run', '--backend-only'])

# Step 2: Wait for the Langflow backend to start (adjust time as needed)
time.sleep(10)  # Adjust this depending on how long Langflow takes to start

# Step 3: Capture the flow_id from the JSON file
json_file_path = Path().cwd() / 'app' / 'RAV_AGENT.json'
flow_id = get_flow_id(json_file_path)

if flow_id:
    # Step 4: Inject the flow_id into the HTML file
    current_folder = Path().cwd()
    html_file_path = current_folder / 'app' / 'chat_widget.html'
    temp_html_file = inject_flow_id_to_html(html_file_path, flow_id)

    if temp_html_file:
        # Step 5: Open the updated HTML file in the browser
        html_file_url = f'file://{temp_html_file.resolve()}'
        webbrowser.open(html_file_url)
else:
    print("Cannot launch the HTML file because the flow_id was not found.")

# Optional: You can handle stopping the Langflow process if needed
# langflow_process.terminate()  # Uncomment to stop the Langflow process when done
