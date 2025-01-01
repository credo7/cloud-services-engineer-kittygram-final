FROM python:3.10

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONUNBUFFERED=1

CMD sh -c "
    echo '🔄 Running migrations...' && \
    python manage.py makemigrations --merge || true && \
    python manage.py migrate --noinput && \
    echo '📦 Collecting static files...' && \
    python manage.py collectstatic --noinput && \
    echo '🚀 Starting backend app...' && \
    python manage.py runserver 0.0.0.0:8000
"
