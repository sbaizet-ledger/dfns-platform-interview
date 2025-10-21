variable "environment" {
  description = "Environment on which this module is deployed"
  type    = string
  validation {
    condition     = can(regex("^(production|staging|development)$", var.environment))
    error_message = "The environment value isn't correct. Accepted values are production, development"
  }
}

variable "vagrant_network" {
  description = "Vagrant network"
  type    = string
}

variable "services" {
  description = "Map of services to create"
  type    = map(any)
}

variable "vault_address" {
  description = "URL to access the vault"
  type    = string
}