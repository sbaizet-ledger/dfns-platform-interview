module "vault" {
  source = "../modules/vault"
  environment = "development"
  vagrant_network = "vagrant_development"
  services = {
    account = {
    db_password = "965d3c27-9e20-4d41-91c9-61e6631870e7"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-account-development"
    }
    gateway = {
    db_password = "10350819-4802-47ac-9476-6fa781e35cfd"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-gateway-development"
    }
    payment = {
    db_password = "a63e8938-6d49-49ea-905d-e03a683059e7"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-payment-development"
    }
  }
  vault_address = "http://vault-development:8200"
}