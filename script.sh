sudo apt-get update
sudo apt-get install ntp -y
sudo service ntp start
sudo systemctl enable ssh.service
sudo apt-get install vsftpd
sudo cp Projet_Technique/vsftpd.conf /etc/vsftpd.conf
sudo cp Projet_Technique/vsftpd.chroot_list /etc/vsftpd.chroot_list
sudo pip install peewee
sudo apt install mariadb-server-10.0 -y
sudo mysql -u root -e "CREATE DATABASE TPFRANCKTHOMAS;" -e "GRANT ALL PRIVILEGES ON TPFRANCKTHOMAS.* TO fp IDENTIFIED BY 'fp';"
sudo apt-get install -y python3-pip libglib2.0-dev
sudo pip install bluepy

# Exécution du script météo
sudo python meteo_bluetooth.py &

sudo pip install pymysql

# Exécution du script peewee
python peeweeTP.py

pip install Flask

mkdir templates

cd ~/Projet_Technique/Flask/
cp home.html ~/templates
cp static ~/

# Exécution du script flask
sudo python script_flask.py &
