output "id" {
  description = "The ID of the virtual machine."
  value       = azurerm_virtual_machine.this.id
}

output "name" {
  description = "The name of the virtual machine."
  value       = azurerm_virtual_machine.this.name
}
