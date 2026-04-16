#!/bin/bash

echo "🚀 Criando docker-compose..."

cat <<EOF > docker-compose.yml
services:
  python:
    build: ./services/python
    container_name: python_api
    ports:
      - "8000:8000"
    restart: unless-stopped
EOF

echo "📦 docker-compose criado!"