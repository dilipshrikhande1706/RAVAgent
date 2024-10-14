import requests

def get_response(query):
    # Assuming you're sending this query to Langflow's running agent
    url = "http://ravagent-ollama:11434/api/v1/ask"  # Update if using a different server
    payload = {"query": query}
    response = requests.post(url, json=payload)
    
    if response.status_code == 200:
        return response.json()
    else:
        return {"error": "Something went wrong."}

