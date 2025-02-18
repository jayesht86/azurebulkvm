# Resource Group and Location
resource_group_name = "existing-resource-group"
location            = "East US"

# VNet and Subnet Details
vnet_name           = "existing-vnet"
subnet_name         = "existing-subne"

# VM Configuration - List of VM Details
vm_config = [
  {
    size              = "Standard_B2ms"
    zone_list         = ["1", "2"]
    vm_count_per_zone = 2
    admin_username    = "adminuser"
    admin_password    = "Password123!"
    os_disk_size_gb   = 30
  },
  {
    size              = "Standard_B4ms"
    zone_list         = ["1" ]
    vm_count_per_zone = 1
    admin_username    = "adminuser"
    admin_password    = "Password123!"
    os_disk_size_gb   = 40
  }
]

# Environment, Region, and Product Codes
environment_code = "d"  # development
region_code      = "eu1"  # East US
product_code     = "pc"  # product code

# VM Sequence Starting Number
sequence_start = 5