variable "sites" {
    type = list(string)
    default = ["ACI-01","ACI-02"]
}

variable "tenant_name" {
    type = string
}

variable "schema_name" {
    type = string
}

variable "template_name" {
    type = string
}

variable "vrf_name" {
    type = string
}

variable "bd_name" {
    type = string
}