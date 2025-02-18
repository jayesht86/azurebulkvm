variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "subnet_name" { type = string }

variable "environment_code" {
  type        = string
  description = "Environment Code (a=alpha, d=development, etc.)"
  validation {
    condition     = length(var.environment_code) == 1 && can(regex("^[adpqstuv]$", var.environment_code))
    error_message = "Environment code must be a single character."
  }
}

variable "region_code" {
  type        = string
  description = "Region Code (3 characters, e.g., eu1, wu1)"
  validation {
    condition     = length(var.region_code) == 3
    error_message = "Region code must be 3 characters."
  }
}

variable "product_code" {
  type        = string
  description = "Product Code (2 characters)"
  validation {
    condition     = length(var.product_code) == 2
    error_message = "Product code must be 2 characters."
  }
}

variable "vm_os_type" {
  type        = string
  description = "OS Type Code (2 characters)"
  validation {
    condition     = length(var.vm_os_type) == 2
    error_message = "OS Type code must be 2 characters."
  }
}

variable "sequence_start" {
  type        = number
  description = "Starting number for VM sequence"
  default     = 1
}

variable "vm_config" {
  type = list(object({
    size              = string
    zone_list         = list(string)
    vm_count_per_zone = number
    admin_username    = string
    admin_password    = string
    os_disk_size_gb   = number
  }))
}