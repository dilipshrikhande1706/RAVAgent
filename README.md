
# RAVAgent

RAVAgent is an AI-powered Retrieval-Augmented Generation (RAG) system designed to assist with tasks related to the Swiss unemployment system (RAV). It leverages **Langflow** and **Ollama's LLaMA** model for interactive responses.

## Prerequisites

Docker desktop is installed.
Git is available*

## Steps

### 1. Clone the Repository
```bash
git clone https://github.com/dilipshrikhande1706/RAVAgent
cd RAVAgent
git checkout docker-langflow-separate-branch
docker-compose up --build 
```
### 2. Incase something doesn't work and you want retry it clean:

```
docker-compose down  
docker system prune -af 
Open your docker desktop and delete containers, images and environments
lsof -i :11434
should not have any process running. if so then kill -9 <process id>
lsof -i :7860  
should not have any process running. if so then kill -9 <process id>
docker-compose up --build 

```
