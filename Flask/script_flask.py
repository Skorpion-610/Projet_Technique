from flask import Flask
from flask import Flask, redirect, url_for, render_template

app = Flask(__name__)

# Route principale pour afficher la page d'acceuil
@app.route('/')
def hello():
    return render_template("home.html")

# Route secondaire pour afficher la page du capteur
@app.route('/capteur')
def capteur():
    return 'Batterie : / Température : / Humiditée : '

# Bouton pour aller sur la page des informations du capteur
@app.route("/redirect_to_capteur")
def redirect_to_capteur():
    return redirect(url_for("capteur"))

if __name__ == '__main__':
    app.run(debug=True)