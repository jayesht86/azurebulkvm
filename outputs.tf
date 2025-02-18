output "vm_names" {
  value = [for vm in module.vm : vm.name]
}