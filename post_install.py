# post_install.py
import subprocess

def install_llava():
    try:
        print("Pulling llava:latest model...")
        subprocess.run(["ollama", "pull", "llava:latest"], check=True)
        print("llava:latest model installed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred: {e}")

if __name__ == "__main__":
    install_llava()
