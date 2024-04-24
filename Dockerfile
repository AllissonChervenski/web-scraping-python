# Use Ubuntu como imagem base
FROM ubuntu:latest

# Atualize e instale as dependências necessárias
RUN apt-get update && \
    apt-get install -y wget libnss3 libxss1 libasound2 unzip python3 python3-pip python3.10-venv  # Instalações em uma linha

# Copie o código-fonte para o contêiner
COPY . /app

# Defina o diretório de trabalho
WORKDIR /app

# Crie o ambiente virtual e instale as dependências
RUN python3 -m venv venv && \
    venv/bin/pip install -r requirements.txt  # Cria e ativa o ambiente virtual, instala dependências

# Instale o Gunicorn no ambiente virtual
RUN venv/bin/pip install gunicorn

# Comando para iniciar o Gunicorn
CMD ["venv/bin/gunicorn", "-w", "4", "-b", "0.0.0.0:${PORT}", "app:app"]
