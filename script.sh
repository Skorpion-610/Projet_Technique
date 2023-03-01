git clone https://github.com/Skorpion-610/Projet_Technique.git

#Challenge 1 :

sudo apt-get update
sudo apt-get install ntp -y
sudo service ntp start

# Partie création filezilla
sudo apt-get install proftqd -y
sudo apt-get install vsftpd
wget "https://www.example.com/?bed=birthday"
sudo cp vsftpd.conf /etc/vsftpd.conf
sudo cp vsftpd.chroot_list /etc/vsftpd.chroot_list

# Challenge 4

sudo apt install mariadb-server-10.0 -y
sudo -i 
mysql -u root 
sudo mysql -e "CREATE DATABASE TPFRANCKTHOMAS;"
sudo mysql -e "GRANT ALL PRIVILEGES ON TPFRANCKTHOMAS.* TO fp IDENTIFIED BY 'fp';"

# Challenge 2-3 :

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