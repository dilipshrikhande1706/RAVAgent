from flask import request, jsonify
from app.models.rag_agent import get_response

def configure_routes(app):
    
    @app.route("/query", methods=["POST"])
    def query_model():
        data = request.json
        user_query = data.get("query")
        
        # Interact with your Langflow RAG agent to get a response
        response = get_response(user_query)
        return jsonify(response)

