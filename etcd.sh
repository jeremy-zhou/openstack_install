#!/bin/bash

yum install etcd -y

crudini --set /etc/etcd/etcd.conf '' ETCD_DATA_DIR "\"/var/lib/etcd/default.etcd\""
#crudini --set /etc/etcd/etcd.conf '' ETCD_LISTEN_PEER_URLS "http://192.168.2.246:2380"
sed -i "s/^#ETCD_LISTEN_PEER_URLS.\+$/ETCD_LISTEN_PEER_URLS=\"http:\/\/192.168.2.246:2380\"/g" /etc/etcd/etcd.conf
crudini --set /etc/etcd/etcd.conf '' ETCD_LISTEN_CLIENT_URLS "\"http://192.168.2.246:2379\""
crudini --set /etc/etcd/etcd.conf '' ETCD_NAME "\"controller\""

#crudini --set /etc/etcd/etcd.conf '' ETCD_INITIAL_ADVERTISE_PEER_URLS "\"http://192.168.2.246:2380\""
sed -i "s/^#ETCD_INITIAL_ADVERTISE_PEER_URLS.\+$/ETCD_INITIAL_ADVERTISE_PEER_URLS=\"http:\/\/192.168.2.246:2380\"/g" /etc/etcd/etcd.conf
crudini --set /etc/etcd/etcd.conf '' ETCD_ADVERTISE_CLIENT_URLS "\"http://192.168.2.246:2379\""
crudini --set /etc/etcd/etcd.conf '' ETCD_INITIAL_CLUSTER "\"controller=http://192.168.2.246:2380\""
crudini --set /etc/etcd/etcd.conf '' ETCD_INITIAL_CLUSTER_TOKEN "\"etcd-cluster-01\""
crudini --set /etc/etcd/etcd.conf '' ETCD_INITIAL_CLUSTER_STATE "\"new\""

systemctl enable --now etcd
systemctl status etcd
sleep 2s

