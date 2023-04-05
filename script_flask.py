from flask import Flask, redirect, url_for, render_template
from peeweeTP import Mesure

app = Flask(__name__, static_url_path='/static')

# Route principale pour afficher la page d'accueil
@app.route('/')
def home():
    return render_template('home.html', data=Mesure.select())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
