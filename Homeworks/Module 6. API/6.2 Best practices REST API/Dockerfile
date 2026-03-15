FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /api

COPY requirements.txt .

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY main.py students.csv config.toml ./
COPY Data ./Data
COPY Logger ./Logger

RUN mkdir -p /api/logs

VOLUME ["/api/logs"]

ENV PYTHONUNBUFFERED=1

CMD ["python", "main.py"]