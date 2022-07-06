#!/bin/bash
apt update
sleep 50
apt-get install -y mongodb
systemctl start mongodb
systemctl enable mongodb
