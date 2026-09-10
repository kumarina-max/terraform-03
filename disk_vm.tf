# disk_vm.tf

# Данные для получения образа Ubuntu
data "yandex_compute_image" "ubuntu_storage" {
  family = "ubuntu-2004-lts"
}


# Ресурс дисков: 3 диска по 1 ГБ
resource "yandex_compute_disk" "storage_disk" {
  count = 3

  name = "storage-disk-${count.index + 1}"
  type = "network-hdd"
  zone = var.default_zone
  size = 1 # 1 ГБ
}

# ВМ storage (одиночная, без count/for_each)
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_storage.id
      size     = 10 # загрузочный диск 10 ГБ
    }
  }

  # Подключение дополнительных дисков через dynamic
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk[*].id
    content {
      disk_id = secondary_disk.value
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}
