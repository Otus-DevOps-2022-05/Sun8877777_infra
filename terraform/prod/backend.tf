terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.45.0"
    }
  }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "acheremisin-bucket"
    region   = "ru-central1"
    key      = "terraform/prod/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
