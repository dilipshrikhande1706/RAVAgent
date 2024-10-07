from dotenv import load_dotenv
import subprocess
import time
import webbrowser
from pathlib import Path
import json

import requests
import json
import shutil
import os
import glob
import re

# shutil.copy('resources/SECO_716_200_d_2019_web.pdf', '~/Library/Caches/langflow/SECO_716_200_d_2019_web.pdf')

# Source folder containing PDF files
src_folder = 'resources'

# Destination folder
dst_folder = os.path.expanduser('~/Library/Caches/langflow')

# Ensure the destination folder exists
os.makedirs(dst_folder, exist_ok=True)

# Find all PDF files in the source folder
pdf_files = glob.glob(os.path.join(src_folder, '*.pdf'))

# Loop through each PDF file and copy it to the destination folder
for pdf_file in pdf_files:
    # Get the destination path for the file
    dst_file = os.path.join(dst_folder, os.path.basename(pdf_file))

    # Copy the PDF file
    shutil.copy(pdf_file, dst_file)
    print(f"Copied: {pdf_file} to {dst_file}")

files = os.listdir(dst_folder)

# Print all the files
# for file in files:
#     print(file)

# Step 1: Run Langflow in the background
langflow_process = subprocess.Popen(['langflow', 'run', '--backend-only'])

# Step 2: Wait for the Langflow backend to start (adjust time as needed)
time.sleep(10)  # Adjust this depending on how long Langflow takes to start

# Step 3: Now you can send requests to the Langflow backend
# For example, you might want to check if it's running:
try:
    response = requests.get('http://127.0.0.1:7860/health')  # Assuming this is the health check endpoint
    if response.status_code == 200:
        print("Langflow is running!")
    else:
        print(f"Unexpected status code: {response.status_code}")
except requests.exceptions.RequestException as e:
    print(f"Error connecting to Langflow: {e}")

# Optional: Add your JSON manipulation or other requests here

# Function to upload the flow JSON to Langflow and run it
def get_flow_id(i_json_file_path, langflow_host="http://127.0.0.1:7860"):
    # Read the JSON file content
    with open(i_json_file_path, 'r') as f:
        flow_data = json.load(f)

    # Assuming Langflow has an endpoint like `/api/v1/flows`
    upload_url = f"{langflow_host}/api/v1/flows"

    try:
        # Send a POST request to upload the flow
        response = requests.post(upload_url, json=flow_data)
        response.raise_for_status()  # Check for HTTP errors

        # Get the flow ID from the response
        r_flow_id = response.json().get('id')

        if r_flow_id:
            print(f"Flow ID: {r_flow_id}")
        else:
            print("Flow ID not found in the response")

        return r_flow_id
    except requests.exceptions.RequestException as e:
        print(f"Error during flow upload: {e}")
        return None

# Function to get flow_id from the JSON file
# def get_flow_id(json_file_path):
#     try:
#         # Open and read the JSON file
#         with open(json_file_path, 'r') as f:
#             flow_data = json.load(f)
#
#         # Extract and return the flow_id
#         flow_id = flow_data.get('id', None)
#         if flow_id:
#             print(f"Flow ID: {flow_id}")
#         else:
#             print("Flow ID not found in the JSON file.")
#         return flow_id
#
#     except FileNotFoundError:
#         print(f"Error: The file {json_file_path} was not found.")
#         return None
#     except json.JSONDecodeError:
#         print("Error: Could not decode the JSON file.")
#         return None

# Function to inject the flow_id as a global JavaScript variable and create a temporary HTML file
def inject_flow_id_to_html(html_file_path, flow_id):
    try:
        # Read the original HTML file content
        with open(html_file_path, 'r') as f:
            html_content = f.read()

        # Regular expression to find the window.flowId variable and update its value
        updated_content = re.sub(
            r'(window\.flowId\s*=\s*["\'])(.*?)(["\'];)',
            r'\1{}\3'.format(flow_id),
            html_content
        )

        # Save the modified HTML content to a temporary file
        with open(html_file_path, 'w') as f:
            f.write(updated_content)

        # print(f"Temporary HTML file created at {temp_html_file}")
        return html_file_path

    except FileNotFoundError:
        print(f"Error: The file {html_file_path} was not found.")
        return None
    except Exception as e:
        print(f"An error occurred while modifying the HTML file: {e}")
        return None


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
langflow_process.terminate()  # Uncomment to stop the Langflow process when done
