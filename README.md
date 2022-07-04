# Sun8877777_infra
Sun8877777 Infra   repository

#Домашнее задание №3
Запуск VM в Yandex Cloud, управление правилами фаервола, настройка SSH подключения, настройка SSH подключения через Bastion Host, настройка VPN сервера и VPN-подключения.

##Цель:
В данном дз студент создаст виртуальные машины в YC. Настроит bastion host и ssh.
В данном задании тренируются навыки: создания виртуальных машин, настройки bastion host, ssh

##Самостоятельное задание №1. 
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

##Дополнительное задание №1.
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

##Дополнительное задание №2.
Подключил ssl сертификат указав в настройках 51.250.14.189.sslip.io в поле Lets Encrypt Domain.
Документация https://docs.pritunl.com/docs/custom-ssl-certificate

bastion_IP = 51.250.14.189
someinternalhost_IP = 10.128.0.20

#Домашнее задание №4

testapp_IP = 51.250.91.35
testapp_port = 9292

##Дополнительное задание
Для поднятия VM достаточно выполнить:
    bash yc_create_cc_with_metadata.sh  # Startup скрипт

metadata.yaml - мета для Startup скрипт
---
#Домашнее задание №5
В данном задании был создан сервисный аккаунт с минимальным набором прав.
Создан service account key file, который использовался при сборки paker -ом образов. С помощью пакер был создан базовый образ с ruby и mongodb.
Также выполнена параметризация сборки с помощью файла variables.json.
В кажестве Дополнительного задания создан  bake-образ reddit-full с использованием systemd unit и также скрипт create-reddit-vm.sh для быстрого запуска ВМ на основе нового образа reddit-full.

#Домашнее задание №6

##Практика IaC с использованием Terraform

###Самостоятельные задания
1. Определите input переменную для приватного ключа,
использующегося в определении подключения для
провижинеров (connection);
  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = true
  }
  Я использовал agent = true, т.к. все мои ключи использую парольную фразу.
2. Определите input переменную для задания зоны в ресурсе
"yandex_compute_instance" "app". У нее должно быть значение
по умолчанию;
main.tf
>   resource "yandex_compute_instance" "app" {
>     count = var.count_inst
>     name  = "reddit-app-${count.index}"
>     zone  = var.zone
variables.tf
>variable "zone" {
>  description = "Zone"
>  # Значение по умолчанию
> default = "ru-central1-a"
}
3. Отформатируйте все конфигурационные файлы используя
команду terraform fmt;
Сделано! Очень крутая штука! не знал о ней раньше)

4. Так как в репозиторий не попадет ваш terraform.tfvars, то
нужно сделать рядом файл terraform.tfvars.example, в
котором будут указаны переменные для образца.
Сделано

## Задания со **
- Создайте файл lb.tf и опишите в нем в коде terraform создание
HTTP балансировщика, направляющего трафик на наше
развернутое приложение на инстансе reddit-app. Проверьте
доступность приложения по адресу балансировщика. Добавьте в
output переменные адрес балансировщика.

Сделано

- Добавьте в код еще один terraform ресурс для нового инстанса
приложения, например reddit-app2, добавьте его в
балансировщик и проверьте, что при остановке на одном из
инстансов приложения (например systemctl stop puma),
приложение продолжает быть доступным по адресу
балансировщика; Добавьте в output переменные адрес второго
инстанса; Какие проблемы вы видите в такой конфигурации
приложения? Добавьте описание в README.md.

Проблема в почти одинаковом коде, если таких ресурсов будет много, сложно будет управлять ими.

- Как мы видим, подход с созданием доп. инстанса копированием
кода выглядит нерационально, т.к. копируется много кода.
Удалите описание reddit-app2 и попробуйте подход с заданием
количества инстансов через параметр ресурса count.
Переменная count должна задаваться в параметрах и по
умолчанию равна 1.

Сделано

- Не забудьте закоммитить добавленный код в репозиторий и
добавить описание в README.md;

Сделано
