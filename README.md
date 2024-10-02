
# RAVAgent

RAVAgent is an AI-powered Retrieval-Augmented Generation (RAG) system designed to assist with tasks related to the Swiss unemployment system (RAV). It leverages **Langflow** and **Ollama's LLaMA** model for interactive responses.

## Prerequisites

- **Python 3.8+**
- **Ollama** (for LLaMA and nomic-embed-text)
- **Langflow**

## Setup

### 1. Clone the Repository
```bash
git clone https://github.com/dilipshrikhande1706/RAVAgent.git
cd RAVAgent
```

### 2. Install Dependencies
```bash
pip install -r requirements.txt
```

### 3. Install and Setup Ollama
Ollama is required to run the LLaMA and nomic-embed-text models locally.
- **Install Ollama**:
  - On macOS:
    ```bash
    brew install ollama
    ```
  - For other platforms, refer to the [Ollama website](https://ollama.com/download).

- **Download the LLaMA Model**:
    ```bash
    ollama pull llama3
    ```

- **Download Nomic-Embed-Text**:
    ```bash
    ollama pull nomic-embed-text
    ```

- **Start Ollama**:
    ```bash
    ollama run llama3
    ```

### 4. Install and Run Langflow
```bash
pip install langflow
langflow run
```

### 5. Load the Langflow Flow
1. Open your browser at `http://localhost:7860`.
2. Upload the flow `RAG_LLAMA_LATAQ.json`.
3. Set the LLaMA model and configure the embeddings using `nomic-embed-text`.

### 6. Run the Agent
Test the agent via Langflow's interface with queries related to RAV processes.

## Environment Variables

Make sure all necessary environment variables, such as API keys, are stored in a `.env` file in the project root.

## Execution in PyCharm

1. Open the project in **PyCharm**.
2. Run the `run_RAVAgent.py` file.

Ensure your Python interpreter is configured correctly.
