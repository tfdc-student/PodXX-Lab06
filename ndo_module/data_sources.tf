data "mso_site" "sites" {
    for_each = toset(var.sites)
    name = each.value
}

data "mso_schema_template" "template" {
    name = var.template_name
    schema_id = mso_schema.schema.id
}
