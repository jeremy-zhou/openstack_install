#!/bin/bash

. admin-openrc
openstack user create --domain default --password-prompt placement
openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement
openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

yum install openstack-placement-api -y
crudini --set /etc/placement/placement.conf placement_database connection mysql+pymysql://placement:396670549@controller/placement
crudini --set /etc/placement/placement.conf api auth_strategy keystone
crudini --set /etc/placement/placement.conf keystone_authtoken auth_url http://controller:5000/v3
crudini --set /etc/placement/placement.conf keystone_authtoken auth_uri http://controller:5000/v3
crudini --set /etc/placement/placement.conf keystone_authtoken memcached_servers controller:11211
crudini --set /etc/placement/placement.conf keystone_authtoken auth_type password
crudini --set /etc/placement/placement.conf keystone_authtoken project_domain_name Default
crudini --set /etc/placement/placement.conf keystone_authtoken user_domain_name Default
crudini --set /etc/placement/placement.conf keystone_authtoken project_name service
crudini --set /etc/placement/placement.conf keystone_authtoken username placement
crudini --set /etc/placement/placement.conf keystone_authtoken password 396670549


echo "<Directory /usr/bin>" >> /etc/httpd/conf.d/00-placement-api.conf
echo "  <IfVersion >= 2.4>" >> /etc/httpd/conf.d/00-placement-api.conf
echo "     Require all granted" >> /etc/httpd/conf.d/00-placement-api.conf
echo "   </IfVersion>" >> /etc/httpd/conf.d/00-placement-api.conf
echo "   <IfVersion < 2.4>" >> /etc/httpd/conf.d/00-placement-api.conf
echo "      Order allow,deny" >> /etc/httpd/conf.d/00-placement-api.conf
echo "      Allow from all" >> /etc/httpd/conf.d/00-placement-api.conf
echo "   </IfVersion>" >> /etc/httpd/conf.d/00-placement-api.conf
echo "</Directory>" >> /etc/httpd/conf.d/00-placement-api.conf

su -s /bin/sh -c "placement-manage db sync" placement
systemctl restart httpd

#/etc/httpd/conf.d/00-placement-api.conf




