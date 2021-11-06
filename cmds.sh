yum -y install nano
yum -y install squid
systemctl start squid
systemctl enable squid

echo "
http_access allow all

http_port 9292

acl SSL_ports port 443

acl Safe_ports port 80 # http

acl Safe_ports port 21 # ftp

acl Safe_ports port 443 # https

acl Safe_ports port 70 # gopher

acl Safe_ports port 210 # wais

acl Safe_ports port 1025-65535 # unregistered ports

acl Safe_ports port 280 # http-mgmt

acl Safe_ports port 488 # gss-http

acl Safe_ports port 591 # filemaker

acl Safe_ports port 777 # multiling http

acl CONNECT method CONNECT

http_access allow localhost manager

http_access allow localhost

coredump_dir /var/spool/squid

refresh_pattern ^ftp: 1440 20% 10080

refresh_pattern ^gopher: 1440 0% 1440

refresh_pattern -i (/cgi-bin/|?) 0 0% 0

refresh_pattern (Release|Packages(.gz)*)$ 0 20% 2880

refresh_pattern . 0 20% 4320
" > /etc/squid/squid.conf

sudo systemctl restart squid

