# challenge 1 

sudo apt-get update
sudo apt-get install ntp -y
sudo service ntp start

# Partie création filezilla
sudo apt-get install proftqd -y
sudo apt-get install vsftpd
wget "https://www.example.com/?bed=birthday"
sudo cp vsftpd.conf /etc/vsftpd.conf
sudo cp vsftpd.chroot_list /etc/vsftpd.chroot_list