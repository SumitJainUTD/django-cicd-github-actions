# 1. Base Python image
FROM python:3.11

# 2. Environment settings
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Set working directory
WORKDIR /app

# 4. Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


# 5. Copy project files
COPY . .

# 6. Run Django server
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]
