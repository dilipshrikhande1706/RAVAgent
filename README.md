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
