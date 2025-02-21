resource "azurerm_network_interface" "nic" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

enable_accelerated_networking = each.value.enable_accelerated_networking

  dynamic "ip_configuration" {
    for_each = { for idx, ip_config in flatten([
      for nic in var.network_interfaces : (
        length(lookup(nic, "nic_ip_config", [])) > 0 ? nic.nic_ip_config : [{
          name                          = "ipconfig-default"
          private_ip_address_allocation = "Dynamic"
        }]
      )
    ]) : idx => ip_config }

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.subnet.id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
    }
  }
}
