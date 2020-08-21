#!/bin/bash

yum install openstack-keystone httpd mod_wsgi -y

crudini --set /etc/keystone/keystone.conf database connection mysql+pymysql://keystone:396670549@controller/keystone
crudini --set /etc/keystone/keystone.conf token provider fernet
su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
keystone-manage bootstrap --bootstrap-password 396670549 \
--bootstrap-admin-url http://controller:5000/v3 \
--bootstrap-internal-url http://controller:5000/v3 \
--bootstrap-public-url http://controller:5000/v3 \
--bootstrap-region-id RegionOne 

sed -i "s/^#ServerName.\+$/ServerName controller/g" /etc/httpd/conf/httpd.conf
ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/
systemctl enable httpd.service
systemctl start httpd.service
systemctl status httpd.service
sleep 2s

