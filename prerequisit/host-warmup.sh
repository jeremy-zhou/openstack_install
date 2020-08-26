#!/bin/bash
yum install -y wget vim git
mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/bak/
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
yum clean all
yum makecache
yum install centos-release-openstack-train -y
yum upgrade -y
echo "you'd better reboot your host now and then continue"
#yum install python-openstackclient
#yum install openstack-selinux
