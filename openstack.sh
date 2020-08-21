#!/bin/bash
yum install centos-release-openstack-train
yum upgrade -y
yum install python-openstackclient
yum install openstack-selinux
