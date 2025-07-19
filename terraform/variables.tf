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
  description = "vnet02"
  type = string
  default = "vnet02"
}

variable "subnet_name" {
  description = "subnet02"
  type = string
  default = "default"
}

variable "nic_name" {
  description = "my-nic02"
  type = string
  default = "my-nic02"
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

variable "vm_names" {
  description = "names of VMs"
  type = list (string)
  default = ["vm1" , "vm2" , "vm3"]
}
