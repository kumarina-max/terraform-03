data "yandex_lockbox_secret_version" "db" {
  secret_id  = "e6q3093j8j6c2jld4lfc"
  version_id = "e6qpqtv662eghotv5jd9"
}

resource "yandex_mdb_mysql_cluster" "this" {
  name        = var.mysql_cluster_name
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.this.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }

  backup_window_start {
    hours   = 3
    minutes = 0
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SUN"
    hour = 4
  }

  host {
    zone             = var.default_zone
    subnet_id        = yandex_vpc_subnet.this.id
    assign_public_ip = false
  }
}

resource "yandex_mdb_mysql_database" "this" {
  cluster_id = yandex_mdb_mysql_cluster.this.id
  name       = var.mysql_database_name
}

resource "yandex_mdb_mysql_user" "this" {
  depends_on = [
    yandex_mdb_mysql_database.this
  ]
  cluster_id = yandex_mdb_mysql_cluster.this.id
  name       = var.mysql_user_name
  password   = data.yandex_lockbox_secret_version.db.entries[0].text_value

  permission {
    database_name = var.mysql_database_name
    roles         = ["ALL"]
  }
}
