#!/bin/bash
software_install() {
    sudo yum update -y
    sudo yum install mc httpd -y 
    }
httpd_config() {
    sudo setenforce 0
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config 
    sudo mkdir /etc/httpd/sites-available /etc/httpd/sites-enabled
    sudo chmod 666 /etc/httpd/conf/httpd.conf /etc/httpd/sites-*
    sudo echo "IncludeOptional sites-enabled/*.conf" >>/etc/httpd/conf/httpd.conf
    sudo cat <<_EOF >/etc/httpd/sites-available/eschool.conf
<VirtualHost *:80>
    #    ServerName www.example.com
    #    ServerAlias example.com
    DocumentRoot /var/www/eSchool/
    ErrorLog /var/log/httpd/eschool/error.log
    CustomLog /var/log/httpd/eschool/requests.log combined
    <Directory /var/www/eSchool/>
            AllowOverride All
    </Directory>
</VirtualHost>
_EOF
sudo chmod 644 /etc/httpd/conf/httpd.conf /etc/httpd/sites-*
sudo mkdir /var/log/httpd/eschool
sudo chown apache:apache /var/log/httpd/eschool
sudo ln -s /etc/httpd/sites-available/eschool.conf /etc/httpd/sites-enabled/eschool.conf
}
build_script () {
cat <<_EOF >/tmp/eschool.sh
    cd /tmp
    tar -xzvf ./artefact.tar.gz
    sudo chown -R apache. /tmp/dist/eSchool
    sudo chmod 444 /tmp/dist/eSchool/.htaccess
    sudo rm -rf /var/www/eSchool
    sudo mv /tmp/dist/eSchool/ /var/www/
    sudo systemctl restart httpd 
_EOF
    sudo mv /tmp/eschool.sh /var/www/
    sudo chmod 755 /var/www/eschool.sh
}
software_install
httpd_config
build_script
