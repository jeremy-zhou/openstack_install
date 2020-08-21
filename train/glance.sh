#!/bin/bash

. admin-openrc
openstack user create --domain default --password-prompt glance
openstack role add --project service --user glance admin
openstack service create --name glance --description "Openstack Image" image
openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

yum install openstack-glance -y
crudini --set /etc/glance/glance-api.conf database connection mysql+pymysql://glance:396670549@controller/glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken www_authenticate_uri http://controller:5000 
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_url http://controller:5000 
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_uri http://controller:5000 
crudini --set /etc/glance/glance-api.conf keystone_authtoken memcached_servers  controller:11211 
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_type password 
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_domain_name  Default 
crudini --set /etc/glance/glance-api.conf keystone_authtoken user_domain_name  Default 
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_name  service 
crudini --set /etc/glance/glance-api.conf keystone_authtoken username  glance 
crudini --set /etc/glance/glance-api.conf keystone_authtoken password 396670549 
crudini --set /etc/glance/glance-api.conf paste_deploy flavor keystone 
crudini --set /etc/glance/glance-api.conf glance_store stores file,http 
crudini --set /etc/glance/glance-api.conf glance_store default_store file 
crudini --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir /var/lib/glance/images/ 

su -s /bin/sh -c "glance-manage db_sync" glance

mkdir -p /var/lib/glance/images
chown -R glance:glance /var/lib/glance/images
chmod -R 0755 /var/lib/glance/images

systemctl enable openstack-glance-api.service
systemctl start openstack-glance-api.service
systemctl status openstack-glance-api.service
sleep 2s





