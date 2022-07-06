provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_storage_bucket" "acheremisin-bucket" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "acheremisin-bucket"
}
