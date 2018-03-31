# Can be used Rhel OS / Amazon Base OS

#!/bin/bash
sudo yum update -y
 
# Install Java 8
sudo yum install -y git java-1.8.0-openjdk.x86_64
sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
 
 
# Test JAVA8 Path
echo $JAVA_HOME
echo $JRE_HOME
 
# Set java 8 as default
sudo /usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
sudo /usr/sbin/alternatives --set javac /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac
 
 
# Install Apache Maven
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
 
# Install Nginx
sudo yum install nginx -y
 
# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins
sudo service jenkins start
sudo chkconfig --add jenkins
 
# Install Python-3.6
sudo yum install -y gcc openssl-devel bzip2-devel
cd /tmp/
wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
tar xzf Python-3.6.4.tgz
cd Python-3.6.4
./configure --enable-optimizations
sudo make altinstall
sudo ln -s /opt/python3/bin/python3.6 /usr/bin/python3.6
rm /tmp/Python-3.6.4.tgz
 
# Check Python version
python3.6 -V
 
 
# Install Pip3.6
sudo yum install python36-setuptools -y
sudo yum install python36-pip -y
 
# Check Pip3.6
pip3.6 -v
 
# Changing user to Jenkins
sudo su -s /bin/bash jenkins
 
# Install Pycode,Pydoc and Pylint and other modules
pip3.6 install pycodestyle --user
pip3.6 install pydocstyle --user
pip3.6 install pylint --user
pip3.6 install pytest --user
pip3.6 install redis --user
pip3.6 install mockredispy --user
pip3.6 install boto3 --user
pip3.6 install mock --user
pip3.6 install moto --user
pip3.6 install pytest-json --user
pip3.6 install coverage --user
pip3.6 install chalice --user
pip3.6 install pymysql --user
