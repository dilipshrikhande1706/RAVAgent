# RAVAgent

RAVAgent is a Retrieval-Augmented Generation (RAG) project that leverages Langflow and Ollama's LLaMA model for conversational AI, designed to assist with tasks related to the Swiss unemployment system (RAV).

## Prerequisites
- Python 3.8+
- [Ollama](https://ollama.com) (Make sure it's running on `http://localhost:11434`)
- [Langflow](https://github.com/logspace-ai/langflow)

## Setup Instructions

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/dilipshrikhande1706/RAVAgent.git
    cd RAVAgent
    ```

2. **Install Dependencies**:
    Install required Python libraries:
    ```bash
    pip install -r requirements.txt
    ```

3. **Set Up Ollama**:
    Download the LLaMA model:
    ```bash
    ollama pull llama3
    ```
    Start Ollama locally:
    ```bash
    ollama run llama3
    ```

4. **Run Langflow**:
    Install Langflow and run it:
    ```bash
    pip install langflow
    langflow run
    ```

5. **Load the Flow**:
   - Open `Langflow` in your browser and upload the flow JSON file (`RAG_LLAMA_LATAQ.json`).
   - Configure the LLaMA model and embeddings.

6. **Run the Agent**:
    Test the agent locally through Langflow's interface.

## Environment Variables
- Make sure to set up any necessary environment variables or API keys in `.env` file.

## Execution Steps

1. Open the project workspace in Pycharm IDE

2. From the project folder, right-click on "run_RAVAgent.py" file and click on Run

This should run langflow project in the background and open the html chat window from where you can start interacting with the RAV Agent :)
( you may face error running the file if you haven't configured interpretter in your pycharm -settings)

Here’s how you can fix it:

1. Set the Python Interpreter in PyCharm:
In PyCharm, go to the top menu and select File > Settings (or PyCharm > Preferences on macOS).
In the left-hand sidebar, go to Project: [your_project_name] > Python Interpreter.
If no interpreter is selected or the wrong one is selected, click the gear icon next to the interpreter dropdown, then select Add or Show All.
Choose the appropriate interpreter:
If you are using a virtual environment, select the Python interpreter from your virtual environment.
If not, choose the system interpreter (e.g., /usr/bin/python3 or similar depending on your setup).
Click OK to save the configuration.
2. Create or Use a Virtual Environment (if applicable):
If you don't have a virtual environment, it's a good idea to create one:
Go to File > Settings > Project > Python Interpreter.
Click the gear icon next to the interpreter dropdown and choose Add.
Select New environment using and choose Virtualenv.
Choose a location for the environment, then click OK to create it.
After creating the virtual environment, install the necessary dependencies (like Langflow) by running:
bash
Copy code
pip install langflow
3. Verify the Langflow Installation:
Ensure that langflow is installed in the environment by running the following command in the PyCharm terminal:
bash
Copy code
pip list | grep langflow
If it's not installed, install it with:
bash
Copy code
pip install langflow
4. Run the Script Again:
Once you've set the correct Python interpreter, try running the run_langflow.py script again by right-clicking the file and selecting Run 'run_langflow'.
By setting a valid interpreter, you should be able to run the script without seeing that error again. Let me know if you encounter any further issues!







You said:
how to check if im using a virtual or system environment
ChatGPT said:
ChatGPT
To check whether you're using a virtual environment or the system environment in PyCharm (or any Python environment), you can follow these steps:

1. Check the Python Interpreter in PyCharm:
In PyCharm, go to File > Settings (or PyCharm > Preferences on macOS).
In the left-hand sidebar, select Project: [your_project_name] > Python Interpreter.
The Python Interpreter dropdown will show you the path to the interpreter being used.
Virtual Environment:
If the path contains a folder like venv, env, or virtualenv, and points to a directory inside your project (e.g., .../RAVAgent/venv/bin/python), you're using a virtual environment.
Virtual environment paths typically look something like:
.../your_project/venv/bin/python (Linux/Mac)
.../your_project/venv/Scripts/python.exe (Windows)
System Environment:
If the path points to a system-wide Python installation (e.g., /usr/bin/python3 on Linux/Mac or C:\Python38\python.exe on Windows), you're using the system Python interpreter.
System interpreter paths might look like:
/usr/bin/python3
/Library/Frameworks/Python.framework/Versions/3.x/bin/python3 (Mac)
C:\Python3x\python.exe (Windows)
2. Check Using the Terminal:
You can also check in the terminal:

Open the PyCharm terminal (bottom pane) or an external terminal.
Run the following command in your project:
For Virtual Environments:
bash
Copy code
pip -V
If you're in a virtual environment, the output will show the path to the virtual environment, like:

vbnet
Copy code
pip 21.1.1 from /path/to/your_project/venv/lib/python3.8/site-packages (python 3.8)
For System Environment:
If it's the system Python, you'll see the path to the system-wide Python installation, like:

bash
Copy code
pip 21.1.1 from /usr/local/lib/python3.8/site-packages (python 3.8)
3. Check for Active Virtual Environment (Command Line):
If you're using an external terminal, you can check if a virtual environment is activated by checking the prompt.

If the virtual environment is active, you'll see the name of the virtual environment in parentheses in the terminal prompt:

ruby
Copy code
(venv) user@machine:~/your_project$
If you're using the system environment, the prompt will not include any such indication:

ruby
Copy code
user@machine:~/your_project$
4. Check with Python Code:
You can also check using Python itself:

Open the PyCharm Python Console or terminal.
Run the following Python code to check if you're in a virtual environment:
python
Copy code
import sys
print(sys.prefix)
Virtual environment: If you're in a virtual environment, this will point to your virtual environment's directory.
System environment: If you're using the system interpreter, it will point to the system-wide Python installation (e.g., /usr or C:\Python38).
Let me know what result you get, and I can help further if needed!






You said:
looks like its a system environment
ChatGPT said:
ChatGPT
Since you're using the system environment, you can consider switching to a virtual environment for your project. Virtual environments help isolate dependencies, prevent conflicts, and allow better control over packages for your project.

Here’s how you can create and configure a virtual environment in PyCharm:

1. Create a Virtual Environment:
In PyCharm, go to File > Settings (or PyCharm > Preferences on macOS).
In the left-hand sidebar, select Project: [your_project_name] > Python Interpreter.
Click the gear icon next to the Python interpreter dropdown and select Add.
Select New environment using, and choose Virtualenv.
Choose a location for the virtual environment (PyCharm will suggest placing it in a directory like venv inside your project folder).
Choose a base interpreter (this is typically your system Python, e.g., /usr/bin/python3 or similar).
Click OK to create the virtual environment.
2. Activate the Virtual Environment:
PyCharm will automatically switch to the virtual environment once it's created. The virtual environment will now be active whenever you run scripts in PyCharm.

3. Install Necessary Packages:
Since the virtual environment starts out empty, you'll need to install the packages you need for your project. In your PyCharm terminal, run:

bash
Copy code
pip install langflow
If you need any other dependencies for your project, install them similarly.

4. Verify the Virtual Environment:
You can verify that the virtual environment is active by running the following command in the terminal:

bash
Copy code
pip -V
The output should show the path to the venv directory within your project.

5. Run Your Project Using the Virtual Environment:
Once the virtual environment is set up, you can try running your run_langflow.py script again in PyCharm. The interpreter should now point to the virtual environment, and everything should work smoothly.

This setup will help ensure that your project dependencies are isolated from system-wide packages, preventing conflicts and improving stability. Let me know if you run into any issues!

