
# Building an AI Chatbot for the Swiss Unemployment Office (RAV) using Langflow

After completing a certification course on "Generative AI for Digital Transformation" at MIT, I was eager to apply what I had learned to a real-world project. The course covered various aspects of AI, from its history to the cutting-edge concepts of prompt engineering and retrieval-augmented generation (RAG) applications. This experience inspired me to dive deeper into building AI agents, and I decided to make something practical that could help recently unemployed individuals navigate the complexities of the Swiss unemployment system, commonly known as RAV.

## First Steps: From Chatbot to RAG Agent

Initially, I experimented with building a basic AI chatbot using Langflow, a Python library that makes constructing and deploying AI agents incredibly straightforward. My first project was creating an AI chatbot for a restaurant, which leveraged ChromaDB to store input data like the restaurant’s menu and FAQs in PDF format. The system worked seamlessly in the Langflow playground, and I used OpenAI's LLM model at first. However, as I wanted a more cost-effective solution, I transitioned to using Llama3, a free alternative.

After successfully building the restaurant chatbot, I set my sights on something more impactful: an AI agent designed to assist recently unemployed individuals in Switzerland with navigating the often complex documentation and processes of the RAV system. The vision was to create a chatbot that not only answers questions in simple terms but also communicates in multiple languages (German, French, Italian, Albanian, Tamil, and English) to better serve the diverse Swiss population.

## The RAVAgent: Architecture and Technology Stack

For this AI agent, I leveraged several key technologies:

- **Langflow**: The framework I used to build and orchestrate the AI chatbot.
- **Llama3 (latest)**: The core large language model powering the chatbot, chosen for its performance and open access.
- **Nomic-Embed-Text**: This embedding model was used to process the input documents and extract meaningful information.
- **Astra DB**: A third-party vector database where I stored the embedded text from input files like government websites and PDF documents.
  
Here’s a breakdown of the architecture:

1. **Data Source**: I utilized Swiss government websites and long PDF documents related to unemployment benefits and procedures. These sources are embedded using Nomic's embedding model.
   
2. **RAG Application**: This retrieval-augmented generation app is designed to retrieve the most relevant information from the vector database in response to user queries, and then the Llama3 model generates human-readable responses.

3. **Multilingual Support**: Although this feature is still in development, the app is designed to answer queries in various languages, making it accessible to a broader user base.

4. **Environment and Dependencies**: I encountered a few challenges related to software version compatibility (Python, Pydantic, and Llama3), which required fine-tuning of the project’s dependencies. I utilized a shell script to streamline this process, ensuring that all necessary components (LLM model, dependencies, and Langflow app) start automatically.

## Challenges Along the Way

Despite the simplicity of using Langflow, I faced several technical challenges:

- **Compatibility Issues**: Ensuring that the right versions of Python, pip, and other dependencies (like Pydantic) were aligned was a constant battle. Version mismatches often led to errors during runtime, particularly when using Llama3 and embedding models.
  
- **Environment Variable Management**: With the help of a friend and contributor, Prasad, I managed to store sensitive database credentials (like API endpoints, tokens, and collection names) as environment variables, improving security and simplifying configuration.

- **Flow ID Issues**: One of the trickier bugs I encountered was related to the `flow_id` parameter, which was often out-of-date in the HTML page. This caused the chatbot to throw a ‘Network Error’ during interactions. I resolved this by ensuring that the correct `flow_id` was fetched and embedded dynamically.

- **Ollama Process Handling**: Another significant issue was ensuring the Ollama process (which runs the Llama3 model) was up and running before starting the Langflow backend. To address this, I created a `run.sh` script that checks the process, installs required software, and launches the app in sequence. This eliminated a lot of manual steps and reduced potential downtime.

## Future Improvements

While the current version of the RAVAgent works well on Mac M1 machines, there are several improvements I plan to implement:

1. **Multiple Language Support**: Right now, the app answers in English, but I aim to incorporate full multilingual capabilities in future updates.

2. **Splitting the Agent**: The current monolithic architecture results in performance bottlenecks, as the agent loads data every time a query is made. I plan to split this into two agents—one for data loading and another for conversational queries—improving response times.

3. **Cross-Platform Compatibility**: I also aim to make the installation process more seamless across different platforms (Mac Intel, Windows, and Linux) by refining the installation scripts.

4. **Deployment on a Hosting Platform**: To make the agent accessible to a wider audience, I am exploring deployment options like Fly.io, Coolify, or Google Cloud Platform (GCP). I already have a $50 free credit on Fly.io that I plan to leverage for this purpose.

![RAVAgent Architecture](./RAVAgent_Architecture.jpg)

## Closing Thoughts

Building the RAVAgent has been an exciting journey that put my newly acquired AI skills to the test. By combining Langflow’s user-friendly interface with the powerful Llama3 model and a robust vector database like Astra DB, I have created an application that I believe could make a tangible difference in helping people navigate the Swiss unemployment system. While challenges like compatibility and architecture design have arisen along the way, overcoming them has only strengthened the project.

With future updates to support multilingual queries and improve performance, I hope to make the RAVAgent a helpful tool for those dealing with the often stressful process of unemployment. If you're curious, feel free to check out the code on [GitHub](https://github.com/dilipshrikhande1706/RAVAgent), and stay tuned for more updates as I continue to improve the app!

---

## Key Technologies Used:
- **Langflow**: Python library for building LLM-based agents.
- **Llama3**: A free and open-source large language model.
- **Astra DB**: Vector database for embedding storage.
- **Nomic-Embed-Text**: Text embedding model.
  
Feel free to try building your own AI agents using these tools—it’s easier than ever!
