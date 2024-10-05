from setuptools import setup
import subprocess

def install_llava_model():
    subprocess.run(['ollama', 'pull', 'llava:latest'], check=True)

install_llava_model()

setup(
    name="RAVAgent",
    version="1.0",
    install_requires=[
        # Add other dependencies here
    ],
)
