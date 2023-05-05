provider "yandex" {
  cloud_id                 = "b1gdh83qoor6p91f65je"
  folder_id                = "b1gmldmegginvb5f7loj"
  zone                     = "ru-central1-a"
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  platform_id = "standard-v2"
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/appuser.pub")}}"
  }
  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашнем задании
      image_id = "fd89a1legnb7jaejcfu4"
    }
  }
  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = "e9bvkoffg887jttgo5ov"
    nat       = true
  }
}
