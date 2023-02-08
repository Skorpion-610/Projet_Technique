#!/bin/bash
sudo apt-get install -y python3-pip libglib2.0-dev
sudo pip install bluepy
cat > meteo_bluetooth.py << EOF
from bluepy.btle import Scanner

scanner = Scanner()
print("Début du scan, c'est parti !")
while True:
    devices = scanner.scan(timeout=3.0)

    for device in devices:
        print(
            f"Appareil trouvé ! Adresse MAC : {device.addr}, "
            f"Puissance du signal : {device.rssi} dB"
        )
        print()
        for adtype, description, value in device.getScanData():
            print(f"Numéro de profil générique :  ({adtype}), Description : {description} = {value}")
        print()
        print()
EOF
sudo python meteo_bluetooth.py