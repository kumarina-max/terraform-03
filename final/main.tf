resource "yandex_vpc_network" "this" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "this" {
  name           = "${var.vpc_name}-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = var.default_cidr
}
