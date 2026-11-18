FROM python:3.9-slim

# Create working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY service/ ./service/
COPY wsgi.py .

# Expose the port the app runs on
EXPOSE 8080

# Define environment variable
ENV FLASK_APP=service:app

# Run gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--access-logfile=-", "wsgi:app"]
