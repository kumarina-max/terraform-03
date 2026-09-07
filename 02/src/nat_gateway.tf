# NAT-шлюз для доступа в интернет
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}   # шлюз с общим выходом в интернет[reference:2]
}

# Таблица маршрутизации с маршрутом по умолчанию через NAT-шлюз
resource "yandex_vpc_route_table" "nat_route_table" {
  name       = "nat-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"              # весь трафик в интернет
    gateway_id         = yandex_vpc_gateway.nat_gateway.id   # через NAT-шлюз[reference:3]
  }
}
