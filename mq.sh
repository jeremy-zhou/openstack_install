#!/bin/bash

yum install rabbitmq-server -y
systemctl enable --now rabbitmq-server.service
systemctl status rabbitmq-server.service
sleep 2s

rabbitmqctl add_user openstack 396670549
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

