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

sudo pip install peewee
sudo apt install mariadb-server-10.0 -y
sudo mysql -u root -e "CREATE DATABASE TPFRANCKTHOMAS;" -e "GRANT ALL PRIVILEGES ON TPFRANCKTHOMAS.* TO fp IDENTIFIED BY 'fp';"

# Challenge 2-3

#!/bin/bash
sudo apt-get install -y python3-pip libglib2.0-dev
sudo pip install bluepy

cat > meteo_bluetooth.py << EOF
from bluepy.btle import Scanner
from peeweeTP import Mesure

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
                print(f"Numéro de profil générique : ({adtype}), Description : {description} = {value}")
                if adtype == 22:
                    batterie = int(value[20:22], 16)
                    temperature = int(value[24:28], 16) * 10 ** -2
                    humidite = int(value[28:32], 16) * 10 ** -2
                    capteur = device.addr
                    print(f"La batterie est à un niveau de {batterie}%")
                    print(f"La température est de {temperature}°C")
                    print(f"L'humidité est de {humidite}%")
                    mesure = Mesure.create(batterie=batterie, temperature=temperature, humidite=humidite, capteur=capteur)
            print()
EOF
sudo python meteo_bluetooth.py &

sudo pip install pymysql

cat > peeweeTP.py << EOF
from peewee import *
from datetime import datetime

# Créer une connexion à la base de données MySQL
database = MySQLDatabase('TPFRANCKTHOMAS', user='fp', password='fp',host='localhost', port=3306)

# Définition du modèle de table
class Mesure(Model):
    id = AutoField()
    capteur = CharField()
    batterie = FloatField()
    temperature = FloatField()
    humidite = FloatField()
    date = DateTimeField(default=datetime.now)
        
    class Meta:
        database = database

database.connect()

# Créer les tables
database.create_tables([Mesure])

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
from flask import Flask, redirect, url_for, render_template
from flask import Flask, redirect, url_for, render_template
from peeweeTP import Mesure

app = Flask(__name__, static_url_path='/static')

# Route principale pour afficher la page d'accueil
@app.route('/')
def home():
    temperatures = []
    for mesure in Mesure.select():
        temperatures.append(mesure.temperature)

    capteurs = []
    for mesure in Mesure.select():
        capteurs.append(mesure.capteur)

    batteries = []
    for mesure in Mesure.select():
        batteries.append(mesure.batterie)

    humidites = []
    for mesure in Mesure.select():
        humidites.append(mesure.humidite)

    dates = []
    for mesure in Mesure.select():
        dates.append(mesure.date)

    return render_template('home.html', dates=dates, temperatures=temperatures, capteurs=capteurs, batteries=batteries, humidites=humidites)

if __name__ == '__main__':
    app.run(debug=True)

EOF
sudo python script_flask.py &