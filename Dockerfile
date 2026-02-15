# Use Python 3.11 slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Create directories for static files, media, and database
RUN mkdir -p /app/staticfiles /app/media /app/data

# Expose port
EXPOSE 8000

# Default command (override in docker-compose for different modes)
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "firstProject.wsgi:application"]
CMD ["sh", "-c", "python manage.py migrate && gunicorn firstProject.wsgi:application --bind 0.0.0.0:8000"]

