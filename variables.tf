variable "pod" {
  type = string
}

variable "nd_username" {
  type = string
}

variable "nd_password" {
  type = string
}

variable "nd_url" {
  type = string
}

variable "platform" {
  type = string
}

variable "sites" {
    type = list(string)
    default = ["ACI-01","ACI-02"]
}