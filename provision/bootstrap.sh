#!/bin/bash

# Download Riemann and Oracle JDK
#curl -o /tmp/cert-forensics-tools-release-el7.rpm https://forensics.cert.org/cert-forensics-tools-release-el7.rpm
#curl -L -H 'Cookie:oraclelicense=accept-securebackup-cookie' -o /tmp/jdk-8u60-linux-x64.rpm http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm creates=/tmp/jdk-8u60-linux-x64.rpm
#curl -o /tmp/riemann-0.2.10-1.noarch.rpm https://aphyr.com/riemann/riemann-0.2.10-1.noarch.rpm

# Install packages
sudo rpm -ivh /tmp/cert-forensics-tools-release-el7.rpm

#sudo yum clean metadata
sudo yum -y install epel-release
sudo yum -y install mariadb-server
sudo yum --enablerepo=forensics -y install daemonize

sudo rpm -ivh /tmp/jdk-8u60-linux-x64.rpm
sudo rpm -ivh /tmp/riemann-0.2.10-1.noarch.rpm

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

