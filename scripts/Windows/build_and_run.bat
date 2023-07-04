@echo off

REM Get the commit hash
for /f %%I in ('git rev-parse --short HEAD') do set "commit_hash=%%I"

REM Read .env file
for /f "usebackq tokens=1,* delims==" %%a in (".env") do (
  if not "%%a" == "" (
    set "%%a=%%b"
    echo %%a=%%b
  )
)


REM Check if the image exists before destroying it
docker inspect %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%commit_hash% >nul 2>&1
if %errorlevel% equ 0 (
    REM Destroy the existing image
    docker rmi %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%commit_hash%
)


REM Build and tag the Docker image
docker build -t %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%commit_hash% --label commit_hash=%commit_hash% --build-arg PORT=8000 .


REM Check if the container exists before removing it
docker inspect %DOCKER_APP_NAME%_container >nul 2>&1
if %errorlevel% equ 0 (
    REM Remove the existing container
    docker rm -f %DOCKER_APP_NAME%_container_latest
)

REM Run the site locally using the tagged image with a custom container name
docker run --env-file .env -p 8000:8000 --name %DOCKER_APP_NAME%_container_latest  %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%commit_hash%
