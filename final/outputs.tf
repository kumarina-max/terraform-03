output "mysql_cluster_id" {
  description = "MySQL cluster ID"
  value       = yandex_mdb_mysql_cluster.this.id
}

output "mysql_host" {
  description = "MySQL host"
  value       = yandex_mdb_mysql_cluster.this.host[0].fqdn
}

output "mysql_database" {
  description = "Application database name"
  value       = yandex_mdb_mysql_database.this.name
}

output "mysql_user" {
  description = "Application database user"
  value       = yandex_mdb_mysql_user.this.name
}
