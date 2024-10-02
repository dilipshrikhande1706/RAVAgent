# Use a Python 3.10 image as the base
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /RAVAgent

# Copy the current directory contents into the container at /app
COPY . /RAVAgent

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
# EXPOSE 8000

# Define environment variables for production (optional)
# ENV FLASK_ENV=production

# Run the application using Gunicorn
CMD ["python3", "run_RAVAgent.py"]