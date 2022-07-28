resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = var.resources.cores
    memory = var.resources.memory
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }


}

resource "null_resource" "app-prov" {
  count = var.prov_enable ? 1 : 0
  connection {
    type  = "ssh"
    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = true
  }

  provisioner "file" {
    content     = templatefile("../modules/app/files/puma.service.tmpl", { env_ip_db = var.env_ip_db })
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "../modules/app/files/deploy.sh"
  }
}

