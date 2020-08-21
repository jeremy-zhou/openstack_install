#!/bin/bash

yum install chrony -y
sleep 2s
sed -i "s/0.centos.pool.ntp.org/ntp.aliyun.com/g" /etc/chrony.conf
sed -i "s/1.centos.pool.ntp.org/ntp.sjtu.edu.cn/g" /etc/chrony.conf
sed -i "s/2.centos.pool.ntp.org/ntp6.aliyun.com/g" /etc/chrony.conf
sed -i "s/3.centos.pool.ntp.org/ntp3.aliyun.com/g" /etc/chrony.conf
sed -i "s/^#allow\s\+192.168.0.0\/16/allow 192.168.0.0\/16/g" /etc/chrony.conf
systemctl enable --now chronyd.service
systemctl status chronyd.service
date
 
