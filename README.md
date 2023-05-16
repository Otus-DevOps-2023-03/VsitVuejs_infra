# VsitVuejs_infra
VsitVuejs Infra repository


ДЗ по установке VPN:
testapp_IP = 84.201.158.146
testapp_port = 9292


ДЗ по установке bastion:
ssh -i ~/.ssh/appuser -J appuser@158.160.101.88 appuser@someinternalhost

Добавить в файл .ssh/config:

Host someinternalhost
   ProxyJump appuser@158.160.101.88

ssh -i ~/.ssh/appuser appuser@someinternalhost

bastion_IP = 158.160.101.88
someinternalhost_IP = 10.128.0.3


ДЗ terraform-2:

В корневой папке terraform реализован bucket, в котором хранится состояние.
Для реализации блокировок нужно добавлять таблицу Yandex Cloud не поддерживает создание таблиц YDB, через
terraform.

Инстансы app и db поднимаются раздельно для приложения reddit.
Через переменные окружения пробрасывается DATABASE_URL в app, ip и порт db.
