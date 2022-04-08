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

/*
Deploy template

THIS IS THE ONLY RESOURCE THAT IS NON-IDEMPOTENT!!!
It will deploy the template in every run and it will not fail
if there is no change and we deploy the template again.
*/
resource "mso_shema_template_deploy" "deployer_stretched" {
  schema_id = mso_schema.ms_prod.id
  template_name = mso_template.stretched_template.name
  side_id = data.mso_site.site1.id //Optional for deploy, mandatory for undeploy
  undeploy = false
}
