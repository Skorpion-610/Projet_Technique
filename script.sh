git clone https://github.com/Skorpion-610/Projet_Technique.git

#Challenge 1

sudo apt-get update
sudo apt-get install ntp -y
sudo service ntp start
sudo systemctl enable ssh.service

# Partie création filezilla
sudo apt-get install vsftpd
sudo cp Projet_Technique/vsftpd.conf /etc/vsftpd.conf
sudo cp Projet_Technique/vsftpd.chroot_list /etc/vsftpd.chroot_list

# Challenge 4

pip install peewee
sudo apt install mariadb-server-10.0 -y
sudo mysql -u root -e "CREATE DATABASE TPFRANCKTHOMAS;" -e "GRANT ALL PRIVILEGES ON TPFRANCKTHOMAS.* TO fp IDENTIFIED BY 'fp';"
sudo python donnees.py &

# Challenge 2-3

#!/bin/bash
sudo apt-get install -y python3-pip libglib2.0-dev
sudo pip install bluepy
pip install peewee

cat > meteo_bluetooth.py << EOF
from bluepy.btle import Scanner

import mysql.connector
import os

scanner = Scanner()
print("Début du scan, c'est parti !")
while True:
    devices = scanner.scan(timeout=3.0)
    for device in devices:
        mac_adresses = 'd6:1c:bf:b7:76:62', 'd6:c6:c7:39:a2:e8', 'd7:ef:13:27:15:29'
        if device.addr in mac_adresses:        
            print(
                f"Appareil trouvé ! Adresse MAC : {device.addr}, "
                f"Puissance du signal : {device.rssi} dB"
            )
            print()
            for adtype, description, value in device.getScanData():
                print(f"Numéro de profil générique :  ({adtype}), Description : {description} = {value}")
                # print(f"{value[20:22]},{value[24:28]},{value[28:32]}")
                batterie = value[20:22]
                temperature = value[24:28]
                humidite = value[28:32]
                if adtype == 22 :
                    decimal_int = int(batterie, 16)
                    print(f"La batterie est à un niveau de",decimal_int,"%")
                    decimal_int = int(temperature, 16)
                    print(f"La température est de",decimal_int*10**-2,"°C")
                    decimal_int = int(humidite, 16)
                    print(f"L'humidité est de",decimal_int*10**-2,"%")
            print()
EOF
sudo python meteo_bluetooth.py &

cat > peeweeTP.py << EOF
from peewee import *

# Créer une connexion à la base de données MySQL
database = MySQLDatabase('TPFRANCKTHOMAS', user='fp', password='fp',host='localhost', port=3306)

# Créer une classe modèle pour chaque table
class TABLEFP(Model):
    # Les champs de la table
    Batterie = FloatField()
    Temperature = FloatField()
    Humidite = FloatField()
    
    class Meta:
        database = database

# Créer les tables dans la base de données
database.connect()
database.create_tables([TABLEFP])
EOF

python peeweeTP.py

# challenge 5 

pip install Flask

mkdir templates

cat > home.html << EOF
<a href="{{ url_for('redirect_to_capteur') }}" class="btn btn-primary">Afficher les données du capteur</a>
EOF

sudo cp home.html templates

cat > script_flask.py << EOF
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
EOF
sudo python script_flask.py &
