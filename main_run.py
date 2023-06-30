import os

print("Enter your OS please ([WINDOWS], Linux, Mac):")
user_os = input().lower()

if not user_os:
    user_os = "windows"

if user_os.startswith("win"):
    os.system("call scripts\\Windows\\build_and_run.bat")
elif user_os.startswith("lin"):
    os.system("bash scripts/Linux/build_and_run.sh")
elif user_os.startswith("mac"):
    os.system("bash scripts/Mac/build_and_run.sh")
