@echo off
setlocal EnableDelayedExpansion
set i=0

for /F "delims=" %%a in (scripts\commit_history.txt) do (
    set /a i+=1
    set "tag[!i!]=%%a"
    echo !i!. %%a
)

echo.
echo Select a tag by its corresponding number.

set /p image_tag="Tag number: "

REM Validation of the input
if not defined tag[%image_tag%] (
    echo Invalid choice
    exit /b
) 

set "full_tag=!tag[%image_tag%]!"
for /f "tokens=2 delims==" %%b in ("!full_tag!") do set "image_tag=%%b"

echo "Pulling:" %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%image_tag%
REM Pull Docker image
docker pull %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%image_tag%

REM Run Docker image
docker run --env-file .env -p 8000:8000 --name %DOCKER_APP_NAME%_container_%image_tag%  %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%image_tag%
