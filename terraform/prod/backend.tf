terraform {

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "my-bucket-1105"
    region     = "ru-central1-a"
    key        = "state.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
