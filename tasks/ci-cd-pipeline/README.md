## Task #4 – Basic CI/CD Pipeline (GitHub Actions)

Two-stage pipeline using Docker and GitHub-hosted runners:

- **build**: build the Docker image and upload it as an artifact (`sample-app-ci.tar`).
- **test**: download and load the image artifact, then run `pytest` inside the container.

### Files

- **Workflow**: `.github/workflows/ci.yml`
- **App & tests**: `tasks/ci-cd-pipeline/sample-app/`
  - `sample_app/app.py`, `__init__.py`
  - `tests/test_app.py`
  - `Dockerfile`, `requirements.txt`

### Local quick check

```bash
cd tasks/ci-cd-pipeline/sample-app
docker build -t sample-app:local .
docker run --rm sample-app:local                  # prints "5"
docker run --rm sample-app:local pytest -q tests  # matches CI behavior
```

### Troubleshooting

- **ImportError (`sample_app`)**: The image sets `ENV PYTHONPATH=/app` and copies both `sample_app/` and `tests/` into `/app`. Ensure your test command targets `tests` inside the container.
- **Artifact not found**: CI uploads `sample-app-ci.tar` from repo root and downloads into `.` (root). The test job then runs `docker load -i sample-app-ci.tar`.