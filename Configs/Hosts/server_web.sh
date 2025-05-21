#!/bin/bash

# Actualizar lista de paquetes e instalar Apache2
apt update && apt install -y apache2

# Crear directorios para los sitios virtuales
mkdir -p /var/www/corp.lab.local /var/www/ituser.lab.local /var/www/impresoras.lab.local /var/www/www.lab.local

# Crear archivos index.html personalizados para cada sitio
echo "<h1>Bienvenido a corp.lab.local</h1>" > /var/www/corp.lab.local/index.html
echo "<h1>Bienvenido a ituser.lab.local</h1>" > /var/www/ituser.lab.local/index.html
echo "<h1>Bienvenido a impresoras.lab.local</h1>" > /var/www/impresoras.lab.local/index.html
echo "<h1>Bienvenido a www.lab.local</h1>" > /var/www/www.lab.local/index.html

# Configurar archivo de VirtualHost para corp.lab.local
cat <<EOT > /etc/apache2/sites-available/corp.lab.local.conf
<VirtualHost *:80>
    ServerName corp.lab.local
    DocumentRoot /var/www/corp.lab.local

    <Directory /var/www/corp.lab.local>
        Require ip 192.168.30.0/24 192.168.50.0/24
    </Directory>
</VirtualHost>
EOT

# Configurar archivo de VirtualHost para ituser.lab.local
cat <<EOT > /etc/apache2/sites-available/ituser.lab.local.conf
<VirtualHost *:80>
    ServerName ituser.lab.local
    DocumentRoot /var/www/ituser.lab.local

    <Directory /var/www/ituser.lab.local>
        Require ip 192.168.50.0/24
    </Directory>
</VirtualHost>
EOT

# Configurar archivo de VirtualHost para impresoras.lab.local
cat <<EOT > /etc/apache2/sites-available/impresoras.lab.local.conf
<VirtualHost *:80>
    ServerName impresoras.lab.local
    DocumentRoot /var/www/impresoras.lab.local

    <Directory /var/www/impresoras.lab.local>
        Require ip 192.168.50.0/24
    </Directory>
</VirtualHost>
EOT

# Configurar archivo de VirtualHost para www.lab.local
cat <<EOT > /etc/apache2/sites-available/www.lab.local.conf
<VirtualHost *:80>
    ServerName www.lab.local
    DocumentRoot /var/www/www.lab.local
</VirtualHost>
EOT

# Habilitar los sitios virtuales y reiniciar Apache
a2ensite corp.lab.local.conf ituser.lab.local.conf impresoras.lab.local.conf www.lab.local.conf
systemctl restart apache2