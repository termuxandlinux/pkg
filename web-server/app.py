#!/data/data/com.termux/files/usr/bin/python
import os
import sys
import subprocess
from flask import Flask

application = Flask(__name__)

html_dir = os.path.join(os.getenv('HOME'), '.html')
export_file = os.path.join(os.getenv('HOME'), 'export_ip_port.txt')

def start_server():
    subprocess.Popen(["termux-open", "-a", "termux-tasker"])
    subprocess.Popen(["flask", "run", "--host=0.0.0.0", "--port=8080"])

def stop_server():
    subprocess.run(["pkill", "flask"])

@application.route('/')
def index():
    return 'Hello, World!'

def show_info():
    print(f"Server is running on http://127.0.0.1:8080")

def setup():
    os.makedirs(html_dir, exist_ok=True)
    subprocess.run(["pip", "install", "flask"])

def export():
    with open(export_file, 'w') as file:
        file.write("Server IP: 127.0.0.1\n")
        file.write("Server Port: 8080\n")

def delete():
    os.remove("/data/data/com.termux/files/usr/bin/web-server")

def display_help():
    print("Commands:")
    print("--start : Start the server and open a terminal where you can enter 'stop' to terminate the script")
    print("--setup : Create necessary directories and install Flask")
    print("--help : Display all commands")
    print("--export : Write IP/Port data to a file")
    print("--delete : Delete the web-server script")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        display_help()
    else:
        command = sys.argv[1]
        if command == "--start":
            start_server()
            show_info()
            while True:
                user_input = input("Enter 'stop' to terminate the script: ")
                if user_input.strip().lower() == 'stop':
                    stop_server()
                    break
        elif command == "--setup":
            setup()
        elif command == "--help":
            display_help()
        elif command == "--export":
            export()
        elif command == "--delete":
            delete()
