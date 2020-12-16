#####################################################
# logdna resource Key attach
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

data "ibm_resource_group" "logdna" {
  name = var.resource_group
}

module "logdna_instance" {
  source  = "terraform-ibm-modules/logdna/ibm//modules/instance"

  service_name        = var.service_name
  resource_group_id   = data.ibm_resource_group.logdna.id
  plan                = var.plan
  region              = var.region
  service_endpoints   = var.service_endpoints
  tags                = var.tags
  parameters          = var.parameters
}

module "logdna_instance-key" {
  source  = "terraform-ibm-modules/logdna/ibm//modules/instance-key"

  resource_key_name       = var.resource_key_name
  resource_instance_id    = module.logdna_instance.logdna_instance_id  
  role                    = var.role
  tags                    = var.key_tags
  parameters              = var.key_parameters
}