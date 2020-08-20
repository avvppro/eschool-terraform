#!/bin/bash
software_install() {
sudo yum update -y
sudo rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install mc git httpd wget nodejs gcc-c++ make yarn java-1.8.0-openjdk-devel nginx setroubleshoot-server -y
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.6.3/ /opt/maven
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
nginx_setup () {
semanage permissive -a httpd_t
cat <<_EOF >./bamboo.conf 
    server {
    listen       80;
    location / {
        proxy_pass http://127.0.0.1:8085;
    }
}
_EOF
    sudo mv ./bamboo.conf /etc/nginx/conf.d/
    sudo systemctl start nginx
    sudo systemctl enable nginx
}
bamboo_setup () {
    cd /root
    wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-7.1.1.tar.gz
    tar xvzf atlassian-bamboo-7.1.1.tar.gz
    cd atlassian-bamboo-7.1.1/
    sudo /usr/sbin/useradd --create-home --home-dir /usr/local/bamboo --shell /bin/bash bamboo
    sudo mkdir /etc/bamboo/
    sudo echo bamboo.home=/etc/bamboo/ >> /root/atlassian-bamboo-7.1.1/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
    }
bamboo_service () {
    cat <<_EOX >/tmp/bamboo.service
[Unit]
Description=Bamboo CI startup script
After=network.target

[Service]
Type=simple
ExecStart=/root/atlassian-bamboo-7.1.1/bin/start-bamboo.sh -fg
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
_EOX
    sudo mv /tmp/bamboo.service /etc/systemd/system/
    sudo systemctl enable bamboo.service
    sudo systemctl start bamboo.service
}
software_install
nginx_setup
bamboo_setup
bamboo_service

# for import after key insert do:
# git clone https://github.com/avvppro/eschool-terraform.git
# sudo mv ./eschool-terraform/export_atlassianbamboo_avvppro_1.zip  /etc/bamboo/backups
# import backup & login vs misha qazwsx