module "vault" {
  source = "../modules/dnfs-app"
  environment = "vagrant_production"
  vagrant_network = "prod"
  services = {
    account = {
    db_password = "396e73e7-34d5-4b0a-ae1b-b128aa7f9977"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-account-production"
    }
    gateway = {
    db_password = "33fc0cc8-b0e3-4c06-8cf6-c7dce2705329"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-gateway-production"
    }
    payment = {
    db_password = "821462d7-47fb-402c-a22a-a58867602e39"
    vault_policy = ["list", "read"]
    vault_endpoint_password = "123-payment-production"
    }
  }
  vault_address = "http://vault-production:8200"
}