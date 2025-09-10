#!/bin/bash
echo "This is a test" > /tmp/test.txt
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd