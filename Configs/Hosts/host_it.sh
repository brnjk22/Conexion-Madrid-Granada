cat <<EOT >> /etc/networks
    auto e0
    iface e0 inet dhcp
EOT
 # Restart networking service

 cat <<EOT > /etc/resolv.conf
    nameserver 192.168.20.80
    nameserver 8.8.8.8
    search lab.local
EOT


echo "Network configuration updated to use DHCP."