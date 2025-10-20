module "vault" {
  source = "../modules/vault"
  environment = "staging"
  vagrant_network = "vagrant_staging"
  services = {
    account = {
    db_password = "396e73e7-34d5-4b0a-ae1b-b128aa7f1234"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-account-staging"
    }
    gateway = {
    db_password = "33fc0cc8-b0e3-4c06-8cf6-c7dce2701234"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-gateway-staging"
    }
    payment = {
    db_password = "821462d7-47fb-402c-a22a-a58867601234"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-payment-staging"
    }
  }
  vault_address = "http://vault-staging:8200"
}