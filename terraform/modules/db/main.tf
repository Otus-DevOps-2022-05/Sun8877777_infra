resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores  = var.resources.cores
    memory = var.resources.memory
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
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
resource "null_resource" "db-prov" {
  count = var.prov_enable ? 1 : 0
  connection {
    type  = "ssh"
    host  = yandex_compute_instance.db.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = true
  }
  provisioner "file" {
    content     = templatefile("../modules/db/files/mongodb.conf.tmpl", { env_private_ip_db = yandex_compute_instance.db.network_interface.0.ip_address })
    destination = "/tmp/mongodb.conf"
  }
  provisioner "remote-exec" {
    script = "../modules/db/files/moved.sh"
  }
}
