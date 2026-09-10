# ansible.tf

locals {
  # Веб-серверы
  webservers = [
    for idx, vm in yandex_compute_instance.web : {
      name = vm.name
      ip = coalesce(
        vm.network_interface[0].nat_ip_address,
        vm.network_interface[0].ip_address
      )
      fqdn = vm.fqdn
    }
  ]

  # Базы данных
  databases = [
    for name, vm in yandex_compute_instance.db : {
      name = vm.name
      ip = coalesce(
        vm.network_interface[0].nat_ip_address,
        vm.network_interface[0].ip_address
      )
      fqdn = vm.fqdn
    }
  ]

  # Storage
  storage = [
    {
      name = yandex_compute_instance.storage.name
      ip = coalesce(
        yandex_compute_instance.storage.network_interface[0].nat_ip_address,
        yandex_compute_instance.storage.network_interface[0].ip_address
      )
      fqdn = yandex_compute_instance.storage.fqdn
    }
  ]
}


# Генерация Ansible inventory
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    webservers = tolist(local.webservers)
    databases  = tolist(local.databases)
    storage    = tolist(local.storage)
  })

  filename = "${path.module}/inventory.ini"
}


# Запуск Ansible
resource "null_resource" "ansible_playbook" {

  depends_on = [
    local_file.ansible_inventory
  ]

  triggers = {
    inventory_hash = sha256(local_file.ansible_inventory.content)
    playbook_hash  = filesha256("${path.module}/test.yml")
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/inventory.ini ${abspath(path.module)}/test.yml"
  }
}


# Список ВМ
output "vm_list" {
  value = concat(
    [
      for vm in yandex_compute_instance.web : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
    [
      for vm in values(yandex_compute_instance.db) : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
    [
      {
        name = yandex_compute_instance.storage.name
        id   = yandex_compute_instance.storage.id
        fqdn = yandex_compute_instance.storage.fqdn
      }
    ]
  )
}
