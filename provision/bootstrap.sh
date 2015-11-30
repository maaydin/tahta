#!/bin/bash

# Behind Proxy Settings
# Uncomment below lines if you are behind a proxy and change http://10.0.2.2:3128 with your proxy address and port
#
# sudo echo "proxy=http://10.0.2.2:3128" >> /etc/yum.conf
# sudo echo "export http_proxy=http://10.0.2.2:3128" >> /etc/bashrc
# sudo echo "export https_proxy=http://10.0.2.2:3128" >> /etc/bashrc
# sudo echo "export HTTP_PROXY=http://10.0.2.2:3128" >> /etc/bashrc
# sudo echo "export HTTPS_PROXY=http://10.0.2.2:3128" >> /etc/bashrc
# source /etc/bashrc

# Stop the 
sudo service firewalld stop

# Download Riemann and Oracle JDK
curl -o /tmp/cert-forensics-tools-release-el7.rpm https://forensics.cert.org/cert-forensics-tools-release-el7.rpm
curl -L -H 'Cookie:oraclelicense=accept-securebackup-cookie' -o /tmp/jdk-8u60-linux-x64.rpm http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm
curl -o /tmp/riemann-0.2.10-1.noarch.rpm https://aphyr.com/riemann/riemann-0.2.10-1.noarch.rpm

# Install packages
sudo rpm -ivh /tmp/cert-forensics-tools-release-el7.rpm

sudo yum clean metadata
sudo yum --enablerepo=forensics -y install epel-release mariadb-server ruby ruby-devel zlib-devel daemonize

sudo rpm -ivh /tmp/jdk-8u60-linux-x64.rpm
sudo rpm -ivh /tmp/riemann-0.2.10-1.noarch.rpm

sudo gem install riemann-tools

# Start services
sudo systemctl start mariadb
sudo systemctl start riemann
sudo chkconfig mariadb on
sudo chkconfig riemann on

# Run SQL scripts
for sql in `ls ./provision/db/*.sql`; do
   echo 'Running sql file `'$sql'`'
   mysql -u root < $sql;
done

# Stop & Disable Firewall Service
sudo service firewalld stop
sudo chkconfig firewalld off

# Run sample health checks
riemann-health &
riemann-apache-status &
riemann-nginx-status &

# Run the application
gem install bundler
bundle install

# Run the application
rackup -p 8080 &