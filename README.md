# Sun8877777_infra
Sun8877777 Infra   repository

Домашнее задание №3
Запуск VM в Yandex Cloud, управление правилами фаервола, настройка SSH подключения, настройка SSH подключения через Bastion Host, настройка VPN сервера и VPN-подключения.

Цель:
В данном дз студент создаст виртуальные машины в YC. Настроит bastion host и ssh.
В данном задании тренируются навыки: создания виртуальных машин, настройки bastion host, ssh

Самостоятельное задание №1. 
Исследовать способ подключения к someinternalhost в одну
команду из вашего рабочего устройства, проверить работоспособность
найденного решения и внести его в README.md в вашем репозитории

Решение:
Можно использовать вызов с опцией -J.
Формат ssh -J <basionhost> <someinternalhost>
1. Добавляем сетификат в ssh-agent
ssh-add ~/.ssh/yandex
2. Проверяем командой ssh-add -L
3. ssh -J appuser@bastion_IP appuser@someinternalhost_IP

Дополнительное задание №1.
    Предложить вариант решения для подключения из консоли при помощи
команды вида ssh someinternalhost из локальной консоли рабочего
устройства, чтобы подключение выполнялось по алиасу
someinternalhost и внести его в README.md в вашем репозитории

Настроить конфиг sudo vim ~/.ssh/config
---
Host bastion
  User appuser
  HostName 51.250.14.189

### Host для последующего перехода
Host someinternalhost
  User appuser
  HostName 10.128.0.20
  ProxyJump bastion
Или сделать алиас и добавить его в конце  ~/.bashrc
alias someinternalhost="ssh -J appuser@51.250.14.189 appuser@10.128.0.20"

Дополнительное задание №2.
Подключил ssl сертификат указав в настройках 51.250.14.189.sslip.io в поле Lets Encrypt Domain.
Документация https://docs.pritunl.com/docs/custom-ssl-certificate

bastion_IP = 51.250.14.189
someinternalhost_IP = 10.128.0.20
---
Домашнее задание №4

testapp_IP = 51.250.91.35
testapp_port = 9292

Дополнительное задание
Для поднятия VM достаточно выполнить:
    bash yc_create_cc_with_metadata.sh  # Startup скрипт

metadata.yaml - мета для Startup скрипт
---
Домашнее задание №5
В данном задании был создан сервисный аккаунт с минимальным набором прав.
Создан service account key file, который использовался при сборки paker -ом образов. С помощью пакер был создан базовый образ с ruby и mongodb.
Также выполнена параметризация сборки с помощью файла variables.json.
В кажестве Дополнительного задания создан  bake-образ reddit-full с использованием systemd unit и также скрипт create-reddit-vm.sh для быстрого запуска ВМ на основе нового образа reddit-full.
