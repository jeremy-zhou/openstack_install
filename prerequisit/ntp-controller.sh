#!/bin/bash
#yum install chrony -y
sleep 2s
sed -i "s/0.centos.pool.ntp.org/$1/g" /etc/chrony.conf
sed -i "s/1.centos.pool.ntp.org/$2/g" /etc/chrony.conf
sed -i "s/2.centos.pool.ntp.org/$3/g" /etc/chrony.conf
sed -i "/3.centos.pool.ntp.org/d" /etc/chrony.conf
sed -i "s/^#allow\s\+192.168.0.0\/16/allow $4\/$5/g" /etc/chrony.conf
#systemctl enable --now chronyd.service
#systemctl status chronyd.service
sleep 2s
date
 
