sudo apt-get update
sudo apt-get install ntp -y
sudo service ntp start
sudo systemctl enable ssh.service
sudo apt-get install vsftpd
sudo cp vsftpd.conf /etc/vsftpd.conf
sudo cp vsftpd.chroot_list /etc/vsftpd.chroot_list
sudo pip install peewee
sudo apt install mariadb-server-10.0 -y
sudo mysql -u root -e "CREATE DATABASE TPFRANCKTHOMAS;" -e "GRANT ALL PRIVILEGES ON TPFRANCKTHOMAS.* TO fp IDENTIFIED BY 'fp';"
sudo apt-get install -y python3-pip libglib2.0-dev
sudo pip install bluepy
sudo pip install pymysql
sudo pip install Flask
sudo pip install requests

# Exécution du script météo
sudo python meteo_bluetooth.py &

# Exécution du script flask
sudo python script_flask.py &

# Exécution du script de récupération des données météo publique
sudo python donnees_meteo.py &
