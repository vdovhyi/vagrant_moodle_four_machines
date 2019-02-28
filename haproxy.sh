#!/usr/bin/env bash
 
# BEGIN ########################################################################
echo -e "-- ------------- --\n"
echo -e "-- BEGIN HAPROXY --\n"
echo -e "-- ------------- --\n"
 
# BOX ##########################################################################
echo -e "-- Updating packages list\n"
sudo yum update -y

#install temp soft
sudo yum install -y mc nano

echo -e "-- Installing HAProxy\n"
sudo yum install -y haproxy > /dev/null 2>&1
sudo systemctl enable haproxy
sudo systemctl start haproxy


/etc/haproxy/haproxy.cfg
global
    log /dev/log local0
    log localhost local1 notice
    user haproxy
    group haproxy
    maxconn 2000
    daemon
 
defaults
    log global
    mode http
    option httplog
    option dontlognull
    retries 3
    timeout connect 5000
    timeout client 50000
    timeout server 50000
 
frontend http-in
    bind *:80
    default_backend webservers
 
backend webservers
    balance roundrobin
    stats enable
    stats auth admin:admin
    stats uri /haproxy?stats
    option httpchk
    option forwardfor
    option http-server-close
    server webserver1 192.168.56.22:80 check
    server webserver2 192.168.56.23:80 check

echo -e "-- Validating HAProxy configuration\n"
haproxy -f /etc/haproxy/haproxy.cfg -c

sudo systemctl restart haproxy

# END ##########################################################################
echo -e "-- ----------- --"
echo -e "-- END HAPROXY --"
echo -e "-- ----------- --"