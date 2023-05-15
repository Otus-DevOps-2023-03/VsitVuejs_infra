locals {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

provider "yandex" {
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  zone                     = local.zone
  service_account_key_file = "/home/user/.ssh/terraform_key.json"
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
