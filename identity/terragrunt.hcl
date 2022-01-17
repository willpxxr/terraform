include {
  path = find_in_parent_folders()
}

prevent_destroy = true

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "common" {
  config_path = "../common"
}

inputs = merge(
  local.common_vars.inputs,
  {
    willpxxr_com_dns_zone_id = dependency.common.outputs.willpxxr_com_dns_zone_id
  }
)
