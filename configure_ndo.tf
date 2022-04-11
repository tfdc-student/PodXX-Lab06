terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
    }
  }
}

provider "mso" {
  # cisco-mso user name
  username = var.nd_username
  # cisco-mso password
  password = var.nd_password
  # cisco-mso url
  url      = var.nd_url
  platform = var.platform
  insecure = true
}

module "ndo_config" {
  source        = "./ndo_module"
  sites         = var.sites
  tenant_name   = var.pod
  schema_name   = "${var.pod}-schema"
  template_name = "${var.pod}-template"
  vrf_name      = "${var.pod}-vrf"
  bd_name       = "${var.pod}-bd"
}

data "mso_schema" "schema" {
    name = "${var.pod}-schema"
    depends_on = [module.ndo_config]
}

# Deploy the template to both sites
resource "mso_schema_template_deploy" "deployer" {
  schema_id = data.mso_schema.schema.id
  template_name = "${var.pod}-template"
  depends_on = [module.ndo_config]
  undeploy = false
}
