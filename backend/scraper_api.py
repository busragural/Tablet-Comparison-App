from flask import Flask, jsonify, request
import subprocess

app = Flask(__name__)

@app.route('/run_scraper', methods=['POST'])
def run_scraper():
    data = request.get_json()
    scraper_name = data.get('scraper_name')

    scraper_scripts = {
        'Mediamarkt': './backend/mediamarkt_scraper.py',
        'Vatan': './backend/vatan_scraper.py',
        'Teknosa': './backend/teknosa_scraper.py',
    }

    scraper_script = scraper_scripts.get(scraper_name)
    if scraper_script:
        try:
            result = subprocess.check_output(['python', scraper_script], stderr=subprocess.STDOUT, text=True)
            return jsonify({'success': True, 'result': result.strip()})
        except subprocess.CalledProcessError as e:
            return jsonify({'success': False, 'error': e.output.strip()})
    else:
        return jsonify({'success': False, 'error': 'Invalid scraper name'})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')