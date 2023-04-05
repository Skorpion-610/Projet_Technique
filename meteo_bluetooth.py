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