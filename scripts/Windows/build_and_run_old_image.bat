@echo off
setlocal enabledelayedexpansion

REM Read .env file
for /f "usebackq tokens=1,* delims==" %%a in (".env") do (
  if not "%%a" == "" (
    set "%%a=%%b"
    echo %%a=%%b
  )
)

REM Ask for image tag
set /p image_tag=Enter image tag: 

echo "Building:" %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%image_tag%
REM Build Docker image
docker build -t %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%image_tag% --label commit_hash=%image_tag% --build-arg PORT=8000 .

REM Run Docker image
docker run --env-file .env -p 8000:8000 --name %DOCKER_APP_NAME%_container_%image_tag%  %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%image_tag%

