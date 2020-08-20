#!/bin/bash
software_install() {
    sudo yum update -y
    sudo yum install polkit mc java-1.8.0-openjdk-devel -y
    sudo mkdir /etc/eschool-backend/
}
eschool_service () {
    cat <<_EOX >/tmp/eschool.service
[Unit]
Description=Eschool backend startup script
After=network.target

[Service]
Type=simple
ExecStart=/bin/java -jar  /etc/eschool-backend/eschool.jar 
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
_EOX
    sudo mv /tmp/eschool.service /etc/systemd/system/
    sudo systemctl enable eschool.service
    sudo systemctl start eschool.service
}
cd_script () {
    cat <<_EOF >/tmp/eschool.sh
#!/bin/bash
sudo systemctl stop eschool.service
sudo mv /tmp/eschool.jar /etc/eschool-backend
sudo systemctl start eschool.service
_EOF
    sudo mv /tmp/eschool.sh /etc/eschool-backend
    sudo chmod 755 /etc/eschool-backend/eschool.sh
}
software_install
eschool_service
cd_script