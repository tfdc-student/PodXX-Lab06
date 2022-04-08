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
}
