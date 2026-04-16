#!/bin/bash

echo "🚀 Criando estrutura do serviço Python..."

# Criar pasta
mkdir -p services/python
cd services/python || exit

# ===============================
# main.py
# ===============================
cat <<EOF > main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "API Python funcionando 🚀"}
EOF

# ===============================
# requirements.txt
# ===============================
cat <<EOF > requirements.txt
fastapi
uvicorn
EOF

# ===============================
# Dockerfile
# ===============================
cat <<EOF > Dockerfile
FROM python:3.11

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

echo "📦 Serviço Python criado com sucesso!"