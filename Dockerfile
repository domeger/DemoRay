# Use the official Python image
FROM python:3.8-slim

# Set environment variables
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Ray and other Python dependencies
RUN pip install --upgrade \
    ray==2.2.0 \
    ray[air]==2.2.0 \
    ray[data]==2.2.0 \
    azure-ai-ml \
    ray-on-aml \
    pydantic==1.10.4  # Ensure compatibility

# Copy the Python script into the container
COPY run_ray_task.py /run_ray_task.py

# Expose Ray dashboard port
EXPOSE 8265

# Start Ray head node with the dashboard enabled and run the Python script
CMD ray start --head --port=6379 --object-store-memory=2147483648 --dashboard-host 0.0.0.0 && python /run_ray_task.py && tail -f /dev/null
