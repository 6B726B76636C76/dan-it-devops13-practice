FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY /src /app

ENV PYTHONUNBUFFERED=1

RUN useradd -m hwuser
USER hwuser

ENTRYPOINT ["python", "main.py"]