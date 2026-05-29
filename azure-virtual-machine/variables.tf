variable "name" {
  type        = string
  description = "Name of the virtual machine."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which to create the virtual machine."
}

variable "location" {
  type        = string
  description = "Azure region for the virtual machine."
}

variable "network_interface_ids" {
  type        = list(string)
  description = "IDs of the network interfaces to attach to the virtual machine."
}

variable "vm_size" {
  type        = string
  description = "Size (SKU) of the virtual machine."
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  type        = string
  description = "Administrator username for the OS profile."
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key authorized for the admin user."
}

variable "os_disk_name" {
  type        = string
  description = "Name of the managed OS disk."
}

variable "image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Marketplace image reference for the OS disk."
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "delete_os_disk_on_termination" {
  type        = bool
  description = "Whether to delete the OS disk automatically when the VM is destroyed."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the virtual machine."
  default     = {}
}
