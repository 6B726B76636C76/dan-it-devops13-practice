FROM python:3.12-slim

RUN useradd -m hwuser

COPY --chown=hwuser:hwuser src/app /app

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

ENV PYTHONUNBUFFERED=1

USER hwuser

EXPOSE 5000

ENTRYPOINT ["python", "app.py"]