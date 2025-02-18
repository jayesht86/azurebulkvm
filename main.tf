terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
}

locals {
  vm_list = flatten([
    for config in var.vm_config : [
      for zone in config.zone_list : [
        for i in range(config.vm_count_per_zone) : {
          name            = format("%s-%s-%s-%s-%02d", var.region_code, var.product_code, var.environment_code, zone, i + var.sequence_start)
          size            = config.size
          admin_username  = config.admin_username
          admin_password  = config.admin_password
          os_disk_size_gb = config.os_disk_size_gb
          zone            = zone
        }
      ]
    ]
  ])
}
module "vm" {
  source              = "C:\\Users\\Jayesh\\OneDrive\\Desktop\\azure\\bulkazureforeachvmcustomname\\module\\vm"
  for_each = { for idx, vm in local.vm_list : "${vm.name}-${idx}" => vm }

  
  name                = each.value.name
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  os_disk_size_gb     = each.value.os_disk_size_gb
  zones               = [each.value.zone]
  resource_group_name = var.resource_group_name
  location            = var.location
  nic_id              = module.nic[each.key].id  # ✅ This is correct
}

module "nic" {
  source = "C:\\Users\\Jayesh\\OneDrive\\Desktop\\azure\\bulkazureforeachvmcustomname\\module\\nic"
  for_each = {
    for idx, vm in local.vm_list : 
    "${vm.name}-${idx}" => vm  # Ensure unique keys by appending index
  }

  resource_group_name = var.resource_group_name
  #name                = "${each.value.name}-nic-${each.key}"
  location            = var.location
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  vm_name             = each.value.name
}

module "disk" {
  for_each = { for idx, vm in local.vm_list : "${vm.name}-${idx}" => vm }

  source              = "C:\\Users\\Jayesh\\OneDrive\\Desktop\\azure\\bulkazureforeachvmcustomname\\module\\disk"
  vm_name             = each.value.name
  disks = [
    { name = "${each.value.name}-data-disk1-${each.key}", size = 64 },
    { name = "${each.value.name}-data-disk2-${each.key}", size = 128 },
    { name = "${each.value.name}-data-disk3-${each.key}", size = 256 }
  ]
  resource_group_name = var.resource_group_name
  location            = var.location
}

#C:\\Users\\Jayesh\\OneDrive\\Desktop\\azure\\bulkazureforeachvmcustomname\\module\\