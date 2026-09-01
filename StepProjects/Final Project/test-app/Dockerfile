FROM python:3.12-slim

COPY /src /app

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED=1

RUN useradd -m appuser
USER appuser

EXPOSE 8000

ENTRYPOINT ["python", "main.py"]
