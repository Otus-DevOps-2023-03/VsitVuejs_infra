output "external_ip_address_app" {
  value = module.app.external_ip_address_app
}
output "external_ip_address_db" {
  value = module.db.external_ip_address_db
}
#output "external_ip_address_lb" {
#  value = tolist(tolist(yandex_lb_network_load_balancer.lb.listener)[0].external_address_spec)[0].address
#}
