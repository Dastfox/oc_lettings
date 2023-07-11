@echo off

REM Get the commit hash
for /f %%I in ('git rev-parse --short HEAD') do set "commit_hash=%%I"

REM Add the commit hash with the current date to a file
echo %date% %time%=%commit_hash% >> scripts/commit_history.txt

REM Read .env file
for /f "usebackq tokens=1,* delims==" %%a in (".env") do (
  if not "%%a" == "" (
    set "%%a=%%b"
    echo %%a=%%b
  )
)

REM Build and tag the Docker image
docker build -t %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%commit_hash% --label commit_hash=%commit_hash% --build-arg PORT=8000 .

REM Run the site locally using the tagged image with a custom container name
docker run --env-file .env -p 8000:8000 --name %DOCKER_APP_NAME%_container_%commit_hash%_latest  %DOCKER_USERNAME%/%DOCKER_APP_NAME%:%commit_hash%

