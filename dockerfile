FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y libnss3 libxss1 libasound2 unzip
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3.10-venv

COPY . /app

RUN python3 -m venv /app/venv

WORKDIR /app/venv/bin

CMD ["pip", "install", "-r", "requirements.txt"] 

CMD ["gunicorn -w 4 -b 0.0.0.0:8001 app:app"]