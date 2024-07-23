# parms file for azure clou

###
variable "vm_names" {
  type    = set(string)
  default = ["vm1", "vm2"]
}
