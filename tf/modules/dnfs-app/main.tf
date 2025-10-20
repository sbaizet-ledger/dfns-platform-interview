resource "vault_audit" "audit" {
  type     = "file"

  options = {
    file_path = "/vault/logs/audit"
  }
}

resource "vault_auth_backend" "userpass" {
  type     = "userpass"
}

resource "vault_generic_secret" "secret" {
  for_each = var.services
  path     = "secret/${var.environment}/${each.key}"

  data_json = <<EOT
{
  "db_user":   "${each.key}",
  "db_password": "${each.value["db_password"]}"
}
EOT
}

resource "vault_policy" "policy" {
  for_each = var.services
  name     = "${each.key}-${var.environment}"

  policy = <<EOT

path "secret/data/${var.environment}/${each.key}" {
    capabilities = ${jsonencode(each.value["vault_policy"])}
}

EOT
}


resource "vault_generic_endpoint" "endpoint" {
  depends_on           = [vault_auth_backend.userpass]
  for_each = var.services
  path                 = "auth/userpass/users/${each.key}-${var.environment}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["${each.key}-${var.environment}"],
  "password": "${each.value["vault_endpoint_password"]}"
}
EOT
}


resource "docker_container" "container" {
  for_each = var.services
  image = "form3tech-oss/platformtest-${each.key}"
  name  = "${each.key}_${var.environment}"

  env = [
    "VAULT_ADDR=${var.vault_address}",
    "VAULT_USERNAME=${each.key}-${var.environment}",
    "VAULT_PASSWORD=${each.value["vault_endpoint_password"]}",
    "ENVIRONMENT=${var.environment}"
  ]

  networks_advanced {
    name = var.vagrant_network
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = [vault_generic_endpoint.endpoint]
}

resource "docker_container" "frontend" {
  image = "docker.io/nginx:latest"
  name  = "frontend_${var.environment}"

  ports {
    internal = 80
    external = 4080
  }

  networks_advanced {
    name = var.vagrant_network
  }

  lifecycle {
    ignore_changes = all
  }
}

