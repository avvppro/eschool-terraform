#!/bin/bash
software_install() {
    sudo yum update -y
    sudo yum install mc java-1.8.0-openjdk-devel -y
}
build_script () {
    sudo mkdir /etc/eschool-backend/
cat <<_EOF >/tmp/eschool.sh
    cd /etc/eschool-backend
    sudo mv /tmp/eschool.jar /etc/eschool-backend
    sudo java -jar ./eschool.jar &

_EOF
    sudo mv /tmp/eschool.sh /etc/eschool-backend
    sudo chmod 755 /etc/eschool-backend/eschool.sh
}
software_install
#build_script



