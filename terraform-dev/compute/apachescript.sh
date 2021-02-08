#!/bin/sh
yum -y install httpd
systemctl enable httpd
systemctl start httpd.service


