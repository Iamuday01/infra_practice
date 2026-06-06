locals {
  env      = "prod"
  project  = "pro-infra"
  location = "East US"

  common_tags = {
    Environment = local.env
    Project     = local.project
    ManagedBy   = "Terraform"
  }

  resource_name_prefix = "${local.project}-${local.env}"
}
