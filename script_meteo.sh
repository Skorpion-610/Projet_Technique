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
sudo python meteo_bluetooth.py