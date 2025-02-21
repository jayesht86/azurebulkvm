variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "network_interfaces" {
  type = list(object({
    name                          = string
    enable_accelerated_networking = optional(bool, false)
    nic_ip_config = optional(list(object({
      name                          = string
      private_ip_address_allocation = optional(string, "Dynamic")
    })), [])
  }))
}
