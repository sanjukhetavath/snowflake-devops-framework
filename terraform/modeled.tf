module "modeled_dev_db" {
  source = "./modules/workspace"

  component_name   = "MODELED"
  environment_name = "DEV"
}

module "modeled_test_db" {
  source = "./modules/workspace"

  component_name   = "MODELED"
  environment_name = "TEST"
}
