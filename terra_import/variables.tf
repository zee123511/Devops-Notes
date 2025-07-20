variable "vm_names" {
  description  =  "names of al vm"
  type = list(string)
  default = ["vm1--osdisk", "vm2--osdisk", "vm3--osdisk"]
}
