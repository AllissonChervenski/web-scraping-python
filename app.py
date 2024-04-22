from flask import Flask, request, jsonify
from scraper import web_scrape  # Importar a função de web scraping

# Iniciar a aplicação Flask
app = Flask(__name__)

# Criar um endpoint para web scraping
@app.route('/scrape', methods=['GET'])
def scrape():
    url = 'http://bianca.com'  # Obter o URL do parâmetro de consulta
    if not url:
        return jsonify({"error": "URL is required"}), 400  # Erro se a URL não for fornecida
    
    try:
        # Executar o web scraping e obter os dados
        data = web_scrape(url)
        return jsonify(data)  # Retornar dados como JSON
    except Exception as e:
        # Lidar com erros e retornar resposta adequada
        return jsonify({"error": str(e)}), 500  # Erro interno do servidor

# Iniciar o servidor Flask
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)  # Configurar para rodar no localhost
