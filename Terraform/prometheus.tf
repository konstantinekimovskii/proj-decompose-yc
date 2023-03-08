resource "yandex_compute_instance" "prometheus" {
  name        = "prometheus"
  hostname    = "prometheus"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  labels = {
    group = "monitoring"
    vds   = "prometheus"
  }

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-ssd"
      size = 15
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
