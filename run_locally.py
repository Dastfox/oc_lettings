import os

print("Enter your OS please ([WINDOWS], Linux, Mac):")
user_os = None


def check_os():
    user_os = input().lower()
    if user_os.startswith("win"):
        return "windows"
    elif user_os.startswith("lin"):
        return "linux"
    elif user_os.startswith("mac"):
        return "mac"
    elif user_os.startswith(""):
        return "windows"
    else:
        return False


while not user_os:
    user_os = check_os()


print("Old image or new image? ([NEW], old):")
user_image = input().lower()


if not user_os:
    user_os = "windows"

if not user_image:
    user_image = "new"

if user_os.startswith("win"):
    if user_image.startswith("old"):
        os.system("call scripts\\Windows\\build_and_run_old_image.bat")
    else:
        os.system("call scripts\\Windows\\build_and_run.bat")
elif user_os.startswith("lin"):
    os.system("bash scripts/Linux/build_and_run.sh")
elif user_os.startswith("mac"):
    os.system("bash scripts/Mac/build_and_run.sh")
