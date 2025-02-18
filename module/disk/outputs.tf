output "disk_ids" {
  value = [for d in azurerm_managed_disk.disk : d.id]
}