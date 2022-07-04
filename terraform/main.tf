# terraform {
#   required_providers {
#     yandex = {
#       source  = "yandex-cloud/yandex"
#       version = "0.45.0"
#     }
#   }
# }

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_compute_instance" "app" {
  count = var.count_inst
  name  = "reddit-app-${count.index}"
  zone  = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = true
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

}
