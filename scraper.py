from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from collections import defaultdict
from webdriver_manager.chrome import ChromeDriverManager

# Definir uma função para executar o web scraping
def web_scrape(url):
        # Configurações do navegador
    options = Options()
    options.add_argument("--headless")  # Para rodar em modo headless
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    
    # Usar o WebDriver Manager para obter o ChromeDriver
    service = Service(ChromeDriverManager().install())
    
    # Inicializar o navegador Chrome usando o serviço com WebDriver Manager
    driver = webdriver.Chrome(service=service, options=options)
    
    try:
        # Acessar o URL especificado
        driver.get(url)
        
        # Extrair informações dos elementos
        elements = driver.find_elements(By.XPATH, '//*')  # Captura todos os elementos
        
        
        # Armazenar informações em uma lista
        data = []
        for elem in elements:
            if elem.tag_name == "title":
                element_info = {
                'tag_name': elem.tag_name,
                'text': driver.title,
                'class_name': elem.get_attribute('class'),
                }
            else:
                element_info = {
                    'tag_name': elem.tag_name,
                    'text': elem.text.strip(),
                    'class_name': elem.get_attribute('class'),
                }
            data.append(element_info)
        
        return data
    finally:
        # Fechar o driver para liberar recursos
        driver.quit()
