#actualizo el sistema
apt-get update

# Instalo los paquetes que puedo necesitar
apt-get install -y apache2
apt-get install -y php
apt-get install -y mysql-server

# Inicio apache
systemctl start apache2
systemctl enable apache2

#doy mensaje de que se hizo la provision correctamente
echo "Provisioning completado!"