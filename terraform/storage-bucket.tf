provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_storage_bucket" "acheremisin-bucket" {
  bucket     = "acheremisin-bucket"
}
