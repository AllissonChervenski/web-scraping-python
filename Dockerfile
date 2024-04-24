# Use Ubuntu como imagem base
FROM ubuntu:latest

# Atualize e instale as dependências necessárias
RUN apt-get update && \
    apt-get install -y wget libnss3 libxss1 libxi6 libasound2 libgconf-2-4  libgl1-mesa-glx \
    fonts-liberation  xdg-utils unzip python3 python3-pip python3.10-venv \
    gnupg \
    --no-install-recommends

# Adicione o repositório do Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list

    # Instale o Google Chrome
RUN apt-get update && apt-get install -y google-chrome-stable \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Defina um comando padrão (não obrigatório)
CMD ["google-chrome", "--headless", "--no-sandbox", "--disable-gpu"]

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
CMD ["venv/bin/gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app"]
