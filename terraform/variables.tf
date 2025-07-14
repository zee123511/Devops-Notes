variable "location" {
  description = "region"
  type = string
  default  = "central india"
}

variable "resource_group_name" {
  description = "rg01"
  type = string
  default = "rg01"
}

variable "vnet_name" {
  description = "vnet01"
  type = string
  default = "vnet01"
}

variable "subnet_name" {
  description = "subnet01"
  type = string
  default = "subnet01"
}

variable "nic_name" {
  description = "my-nic"
  type = string
  default = "my-nic"
}

variable "vm_name" {
  description = "vmterra01"
  type = string
  default = "vmterra1"
}

variable "admin_username" {
  description = "admin_username"
  type = string
  default = "zee12351"
}
