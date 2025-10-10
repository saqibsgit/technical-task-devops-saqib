FROM python:3.11-slim
WORKDIR /app

# Copy dependencies and install
COPY requirements.txt /app/requirements.txt
RUN python -m pip install -U pip && python -m pip install -r requirements.txt

# Copy application code and tests
COPY sample_app /app/sample_app
COPY tests /app/tests

# make the package importable
ENV PYTHONPATH=/app

# default cmd (CI overrides this with pytest)
CMD ["python", "-c", "from sample_app.app import add; print(add(2,3))"]
