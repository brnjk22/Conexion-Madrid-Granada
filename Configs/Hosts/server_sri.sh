
#!/bin/bash

# Actualizar repositorios e instalar servicios necesarios
apt update && apt install -y isc-dhcp-server bind9 dnsutils

# Configuración del servidor DHCP
cat <<EOT > /etc/dhcp/dhcpd.conf
default-lease-time 600;
max-lease-time 7200;
authoritative;

# Configuración de subred para VLAN 30
subnet 192.168.30.0 netmask 255.255.255.0 {
    range 192.168.30.100 192.168.30.200;
    option routers 192.168.30.1;
    option domain-name-servers 192.168.20.80;
    option domain-name "lab.local";
}

# Configuración de subred para VLAN 40
subnet 192.168.40.0 netmask 255.255.255.0 {
    range 192.168.40.100 192.168.40.200;
    option routers 192.168.40.1;
    option domain-name-servers 192.168.20.80;
    option domain-name "lab.local";
}

# Configuración de subred para VLAN 50
subnet 192.168.50.0 netmask 255.255.255.0 {
    range 192.168.50.100 192.168.50.200;
    option routers 192.168.50.1;
    option domain-name-servers 192.168.20.80;
    option domain-name "lab.local";
}
EOT

# Reiniciar el servicio DHCP
systemctl restart isc-dhcp-server

# Configuración del servidor DNS (BIND9)
cat <<EOT > /etc/bind/named.conf.local
zone "lab.local" {
    type master;
    file "/etc/bind/db.lab.local";
};

zone "20.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.20";
};
EOT

# Archivo de zona directa
cat <<EOT > /etc/bind/db.lab.local
\$TTL 604800
@   IN  SOA ns.lab.local. admin.lab.local. (
        2025051401 ; Serial
        604800     ; Refresh
        86400      ; Retry
        2419200    ; Expire
        604800 )   ; Negative Cache TTL

@       IN  NS  ns.lab.local.
ns      IN  A   192.168.20.50

; Registros A
www         IN  A   192.168.20.50
impresoras  IN  A   192.168.20.50
ituser      IN  A   192.168.20.50
corp        IN  A   192.168.20.50
EOT

# Archivo de zona inversa
cat <<EOT > /etc/bind/db.192.168.20
\$TTL 604800
@   IN  SOA ns.lab.local. admin.lab.local. (
        2025051401 ; Serial
        604800     ; Refresh
        86400      ; Retry
        2419200    ; Expire
        604800 )   ; Negative Cache TTL

@       IN  NS  ns.lab.local.
50      IN  PTR ns.lab.local.
EOT
# Configurar el archivo named.conf.options para reenviar consultas DNS a servidores públicos
cat <<EOT > /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";

    forwarders {
        8.8.8.8;
        1.1.1.1;
    };

    allow-query { any; };
    recursion yes;
};
EOT

# Reiniciar el servicio DNS
systemctl restart bind9


