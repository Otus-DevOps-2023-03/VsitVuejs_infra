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


ДЗ ansible-1:
Установили ansible, создали свой первый плей-бук.

ДЗ ansible-2:
Вынесли установку и настройку конфигов для нашего приложения в ansible.
Также задействовали ansible для формирования образа через packer, т.е. все баш скрипты удалили.

ДЗ ansible-3:
Создали роли для развертывания приложения, теперь мы можем переиспользовать задачи с разными переменными.
Настроили окружения stage и prod. Добавили роль создания пользователей и ansible_vault
