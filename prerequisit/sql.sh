#!/bin/bash

yum install mariadb mariadb-server python2-PyMySQL -y
> /etc/my.cnf.d/openstack.cnf

crudini --set /etc/my.cnf.d/openstack.cnf mysqld bind-address 192.168.179.129
crudini --set /etc/my.cnf.d/openstack.cnf mysqld default-storage-engine innodb
crudini --set /etc/my.cnf.d/openstack.cnf mysqld innodb_file_per_table on
crudini --set /etc/my.cnf.d/openstack.cnf mysqld max_connections 4096
crudini --set /etc/my.cnf.d/openstack.cnf mysqld collation-server utf8_general_ci
crudini --set /etc/my.cnf.d/openstack.cnf mysqld character-set-server utf8

systemctl enable --now mariadb.service
systemctl status mariadb.service
sleep 2s
