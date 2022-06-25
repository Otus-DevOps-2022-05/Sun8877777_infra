#!/bin/bash
apt-get install -y mongodb
systemctl start mongodb
systemctl enable mongodb
