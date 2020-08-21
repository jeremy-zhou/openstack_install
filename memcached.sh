#!/bin/bash

yum install memcached python-memcached -y
crudini --set /etc/sysconfig/memcached '' OPTIONS "-l 127.0.0.1,::1,controller"
systemctl enable --now memcached.service
systemctl status memcached.service
sleep 2s
