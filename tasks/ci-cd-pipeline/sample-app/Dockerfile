FROM python:3.11-slim
WORKDIR /app

# Copy dependencies and install
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code and tests
COPY sample_app /app/sample_app
COPY tests /app/tests

# Default command is benign; CI overrides with `pytest -q`
CMD ["python", "-c", "from sample_app.app import add; print(add(2,3))"]
