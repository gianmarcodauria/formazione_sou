FROM python:3.9-slim
# Installa procps per permetterti di usare 'ps' dentro il container
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
# -u disabilita il buffering dell'output per vedere i print subito
CMD ["python", "-u", "shores.py"]