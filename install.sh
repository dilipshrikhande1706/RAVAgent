#!/bin/bash

# Install dependencies
pip install -r requirements.txt

# Install the llava:latest model
ollama pull llava:latest

echo "Installation complete!"
