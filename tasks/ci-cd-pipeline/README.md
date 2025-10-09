# Task #4 – Basic CI/CD Pipeline (GitHub Actions)

This pipeline demonstrates a minimal two-stage CI/CD setup using GitHub Actions:
- **build**: builds a Docker image for a simple Python CLI, and publishes the image tar as an artifact.
- **test**: downloads the image artifact, loads it into Docker, and runs tests **inside** the container.

## How it Works
1. `build` job:
   - `docker build` in `tasks/ci-cd-pipeline/sample-app`
   - saves the image as `sample-app-ci.tar` and uploads it as a build artifact

2. `test` job:
   - downloads `sample-app-ci.tar`, `docker load` into the runner
   - runs `pytest` **in the container** to satisfy "use Docker to build and run your application in the pipeline"

## Assumptions
- Using GitHub-hosted runners (`ubuntu-latest`) as the "cloud-based service".
- Tests are executed inside the Docker image constructed in the build stage.

## Local (optional)
```bash
cd tasks/ci-cd-pipeline/sample-app
docker build -t sample-app:local .
docker run --rm sample-app:local  # prints 5
# To run tests inside the image (same as CI):
docker run --rm sample-app:local pytest -q
```