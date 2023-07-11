import os


def get_user_os():
    while True:
        user_os = input("Enter your OS please ([WINDOWS], Linux, Mac): ").lower()
        if user_os.startswith("win") or user_os == (""):
            return "CMD"
        elif user_os.startswith("lin") or user_os.startswith("mac"):
            return "BASH"


def get_user_image():
    while True:
        user_image = input("Old image or new image? ([BUILD], pull): ").lower()
        if user_image.startswith("b") or user_image == (""):
            return "build"
        elif user_image.startswith("p"):
            return "pull"


def execute_command(script_type, command):
    os.system(f"call scripts\\{script_type}\\{command}.bat")


user_script_type = get_user_os()
user_image = get_user_image()

if not user_script_type:
    user_script_type = "CMD"

if not user_image:
    user_image = "build"

execute_command(user_script_type, f"{user_image}_and_run")
