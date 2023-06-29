terraform {

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.80.0"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "my-bucket-1105"
    region     = "ru-central1-a"
    key        = "state.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

locals {
  cloud_id  = "b1gdh83qoor6p91f65je"
  folder_id = "b1gmldmegginvb5f7loj"
  zone      = "ru-central1-a"
}

provider "yandex" {
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
  zone      = local.zone
  service_account_key_file = "/home/user/.ssh/terraform_key2.json"
}

resource "yandex_iam_service_account" "sa" {
  folder_id   = local.folder_id
  description = "Service account for terraform"
  name        = "sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "keys" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Access keys for object storage"
}

resource "yandex_kms_symmetric_key" "key-storage" {
  name              = "key-storage"
  description       = "key-storage"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // 1 год
}

resource "yandex_storage_bucket" "my-bucket-1105" {
  bucket     = "my-bucket-1105"
  access_key = yandex_iam_service_account_static_access_key.keys.access_key
  secret_key = yandex_iam_service_account_static_access_key.keys.secret_key

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-storage.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning {
    enabled = true
  }

}




#provider "yandex" {
#  service_account_key_file = "/home/user/.ssh/terraform_key.json"
#  cloud_id                 = "b1gdh83qoor6p91f65je"
#  folder_id                = "b1gmldmegginvb5f7loj"
#  zone                     = "ru-central1-a"
#}
#
#terraform {
#  backend "s3" {
#    endpoint   = "storage.yandexcloud.net"
#    bucket     = "my-bucket"
#    region     = "ru-central1-a"
#    key        = "state.tfstate"
#
#    access_key = "YCAJEDl1FYTFZ7vcmioIn3gxN"
#    secret_key = "YCOuBRdHQKY7yIXX_7dvq91FE0DsONPtVaxgT2W-"
#    skip_region_validation      = true
#    skip_credentials_validation = true
#  }
#}
#
#resource "yandex_iam_service_account" "sa" {
#  folder_id   = "b1gmldmegginvb5f7loj"
#  description = "Service account for terraform"
#  name        = "sa"
#}
#
#resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
#  folder_id = "b1gmldmegginvb5f7loj"
#  role      = "storage.admin"
#  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
#}
#
#resource "yandex_iam_service_account_static_access_key" "keys" {
#  service_account_id = yandex_iam_service_account.sa.id
#  description        = "Access keys for object storage"
#}
#
#resource "yandex_kms_symmetric_key" "key-storage" {
#  name              = "key-storage"
#  description       = "key-storage"
#  default_algorithm = "AES_128"
#  rotation_period   = "8760h" // 1 год
#}
#
#resource "yandex_storage_bucket" "my-bucket" {
#  bucket = "my-bucket"
#
#  access_key = yandex_iam_service_account_static_access_key.keys.access_key
#  secret_key = yandex_iam_service_account_static_access_key.keys.secret_key
#
#  server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = yandex_kms_symmetric_key.key-storage.id
#        sse_algorithm     = "aws:kms"
#      }
#    }
#  }
#
#  versioning {
#    enabled = true
#  }
#}
