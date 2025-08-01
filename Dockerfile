# Start from a lightweight Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port for Streamlit
EXPOSE 8000

# Run Streamlit on container start
CMD ["streamlit", "run", "app.py", "--server.port=8000", "--server.address=0.0.0.0"]
