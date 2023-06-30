@echo off

REM Get the commit hash
for /f %%I in ('git rev-parse --short HEAD') do set "commit_hash=%%I"

REM Run linting with Black
black .


REM Check if the image exists before destroying it
docker inspect dastfox/oc_lettings:%commit_hash% >nul 2>&1
if %errorlevel% equ 0 (
    REM Destroy the existing image
    docker rmi dastfox/oc_lettings:%commit_hash%
)


REM Build and tag the Docker image
docker build -t dastfox/oc_lettings:%commit_hash% --label commit_hash=%commit_hash% .


REM Check if the container exists before removing it
docker inspect oc_lettings_container >nul 2>&1
if %errorlevel% equ 0 (
    REM Remove the existing container
    docker rm -f oc_lettings_container
)

REM Run the site locally using the tagged image with a custom container name
docker run -p 8000:8000 --name oc_lettings_container dastfox/oc_lettings:%commit_hash%


REM Run the tests in the new container
docker exec oc_lettings_container python manage.py test


