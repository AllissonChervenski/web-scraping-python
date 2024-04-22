apt-get update
apt-get install -y libnss3 libxss1 libasound2 unzip

# Obter o diretório onde o script Python está localizado
script_dir=$(dirname "$(realpath $0)")

# Baixar o ChromeDriver
wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip"

# Descompactar para o diretório do script
unzip /tmp/chromedriver.zip -d "$script_dir"

# Tornar o ChromeDriver executável
chmod +x "$script_dir/chromedriver"

echo "export PATH=\$PATH:$script_dir" >> ~/.bashrc

# Recarregar o arquivo .bashrc para aplicar as mudanças
source ~/.bashrc

