##Habilitar reenvío de paquetes

cat <<EOT >> /etc/sysctl.conf
    net.ipv4.ip_forward=1
EOT


## Configurar NAT con iptables
iptables -t nat -A POSTROUTING -o e0 -j MASQUERADE
