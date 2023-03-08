resource "yandex_alb_target_group" "webservers" {
  name      = "webservers-group"

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
    ip_address   = "${yandex_compute_instance.web-server1.network_interface.0.ip_address}"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-b.id}"
    ip_address   = "${yandex_compute_instance.web-server2.network_interface.0.ip_address}"
  }
}
