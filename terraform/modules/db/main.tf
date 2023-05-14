resource "yandex_compute_instance" "db" {
  name        = "reddit-db"
  platform_id = "standard-v2"

  labels = {
    tags = "reddit-db"
  }

  resources {
    cores         = 2
    memory        = 2
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

  provisioner "remote-exec" {
    inline = ["sleep 10",
              "sudo sed -i \"s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0,\" /etc/mongod.conf",
              "sudo systemctl restart mongod"
              ]
  }


  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
}
