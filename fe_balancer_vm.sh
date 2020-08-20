#!/bin/bash
software_install() {
    sudo yum update -y
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
    sudo yum install mc nginx setroubleshoot-server -y    
}
nginx_config() {
 semanage permissive -a httpd_t
    cat <<_EOF >./frontend_lb.conf 
    upstream frontend { 
        ip_hash;
        server 192.168.33.201:80;
        server 192.168.33.202:80;
    }
    server {
<<<<<<< HEAD
        server_name  avvppro.xyz www.avvppro.xyz;
=======
        listen       80;
        server_name  18.159.15.164;
>>>>>>> bambooCI
        location /{
            proxy_pass http://frontend;
        }
    }
_EOF
    sudo mv ./frontend_lb.conf /etc/nginx/conf.d/
    sudo systemctl start nginx
    sudo systemctl enable nginx
}
ssl_certificate() {
    sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
    sudo yum install certbot python2-certbot-nginx -y
    sudo certbot --nginx --non-interactive --agree-tos -m avvppro@gmail.com --domains avvppro.xyz
    sudo echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)'\
     && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null
}
software_install
nginx_config
ssl_certificate