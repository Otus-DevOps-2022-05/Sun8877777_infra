#!/bin/bash
yc compute instance create \
  --name reddit-app-full \
  --zone ru-central1-a \
  --create-boot-disk name=disk1,size=10,image-id=fd80208p2c38vanc8cmp \
  --public-ip \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/yandex.pub
