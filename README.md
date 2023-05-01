# VsitVuejs_infra
VsitVuejs Infra repository

ssh -i ~/.ssh/appuser -J appuser@158.160.101.88 appuser@someinternalhost

Добавить в файл .ssh/config:

Host someinternalhost
   ProxyJump appuser@158.160.101.88

ssh -i ~/.ssh/appuser appuser@someinternalhost

bastion_IP = 158.160.101.88
someinternalhost_IP = 10.128.0.3
