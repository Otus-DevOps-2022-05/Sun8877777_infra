#!/bin/bash
sudo mv /tmp/mongodb.conf /etc/mongodb.conf
sudo systemctl stop mongodb
sleep 10
sudo systemctl start mongodb

