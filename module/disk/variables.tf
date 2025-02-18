
variable "disk_size" {
  description = "The size of the disks for the VMs in GB."
  type        = number
  default     = 100  # Set default disk size (can be overridden per VM)
}

variable "storage_account_type" {
  description = "The type of storage account for the disks (Standard_LRS, Premium_LRS)."
  type        = string
  default     = "Standard_LRS"  # Default to Standard_LRS if not specified
}

variable "disk_count" {
  description = "Number of additional data disks to attach per VM."
  type        = number
  default     = 0  # Default to no additional disks
}
/* variable "name" {
  description = "Disk name"
  type        = string
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
} */
variable "vm_name" {
  description = "The name of the VM associated with the disk"
  type        = string
}

variable "disks" {
  description = "List of disks for this VM"
  type = list(object({
    name = string
    size = number
  }))
}




variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

