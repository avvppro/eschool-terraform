#!/bin/bash
software_install() {
sudo yum update -y
sudo yum install mc git httpd java-1.8.0-openjdk-devel -y
sudo setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config 
cat <<_EOF >maven.sh
    export JAVA_HOME=/usr/lib/jvm/jre-openjdk
    export M2_HOME=/opt/maven
    export MAVEN_HOME=/opt/maven
    export PATH=/opt/apache-maven-3.6.3/bin:$PATH
_EOF

    chmod 777 maven.sh
    sudo mv maven.sh /etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh
}
bamboo_setup () {
    wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-7.1.1.tar.gz
    tar xvzf atlassian-bamboo-7.1.1.tar.gz
    cd atlassian-bamboo-7.1.1/
    sudo /usr/sbin/useradd --create-home --home-dir /usr/local/bamboo --shell /bin/bash bamboo
    sudo mkdir /etc/bamboo/
    sudo echo bamboo.home=/etc/bamboo/ >> /home/ansible/atlassian-bamboo-7.1.1/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
    sudo ./bin/start-bamboo.sh
}
software_install
