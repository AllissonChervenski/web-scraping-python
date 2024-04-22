apt-get update
apt-get install -y libnss3 libxss1 libasound2 unzip
wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip"
unzip /tmp/chromedriver.zip -d /root/.cache/selenium/chromedriver/
chmod +x /root/.cache/selenium/chromedriver/chromedriver
