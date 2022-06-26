#!/bin/bash
echo "=========Start init scripts========="

echo "=========Install Ruby ========="
sudo apt update && sudo apt install -y ruby-full ruby-bundler build-essential
echo "=========Install Mongo ========="
sudo apt-get install -y mongodb && sudo systemctl start mongodb &&  sudo systemctl enable mongodb && sleep 10
echo "=========Build and start service ========="
sudo apt install -y git && git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
echo "=========Create systemd Unit ========="
cat << EOF > /etc/systemd/system/puma-reddit.service
[Unit]
Description=Puma OTUS reddit app
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/reddit
ExecStart=/usr/local/bin/puma
Restart=always

[Install]
WantedBy=multi-user.target

EOF
echo "=========END init scripts========="
chmod 664 /etc/systemd/system/puma-reddit.service

systemctl daemon-reload

systemctl enable puma-reddit.service

systemctl start puma-reddit.service

