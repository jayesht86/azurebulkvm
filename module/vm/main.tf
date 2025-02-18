resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [var.nic_id]
  size                  = var.size
  zone                  = var.zones[0] # Since zones is a list, we pick the first item.

  os_disk {
    name                 = "${var.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = var.name
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  tags = {
    environment = "development"
  }
}
