terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
    }
  }
}

# Create Tenant
resource "mso_tenant" "tenant" {
  name         = var.tenant_name
  display_name = var.tenant_name

  dynamic "site_associations" {
    for_each = toset(var.sites)
    content {
      site_id = data.mso_site.sites[site_associations.value].id
    }
  }
}

# Schema and Templates
resource "mso_schema" "schema" {
  name          = var.schema_name
  template_name = var.template_name
  tenant_id     = mso_tenant.tenant.id
}

# Associate each site to the same Schema
resource "mso_schema_site" "sites_sch" {
  for_each = toset(var.sites)
  schema_id       =  mso_schema.schema.id
  site_id         =  data.mso_site.sites[each.value].id
  template_name   =  var.template_name
}

# VRF
resource "mso_schema_template_vrf" "vrf" {
  template     = var.template_name
  schema_id    = mso_schema.schema.id
  name         = var.vrf_name
  display_name = var.vrf_name
}

# BD
resource "mso_schema_template_bd" "bd" {
  schema_id              = mso_schema.schema.id
  template_name          = var.template_name
  name                   = var.bd_name
  display_name           = var.bd_name
  vrf_name               = mso_schema_template_vrf.vrf.name
}
