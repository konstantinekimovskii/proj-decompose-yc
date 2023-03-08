resource "yandex_compute_instance" "web-server2" {
  name        = "web-server2"
  hostname    = "web-server2"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  labels = {
    group = "web-servers"
    vds   = "web-server2"
  }

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat_ip_address = true
    security_group_ids = [ yandex_vpc_security_group.sec-group.id ]
  }

  metadata = {
    ssh-keys  = "${var.username}:${file(var.public_key_path)}"
  }
}
