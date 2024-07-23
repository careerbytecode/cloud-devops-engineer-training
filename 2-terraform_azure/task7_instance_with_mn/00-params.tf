# parms file for azure clou

###
variable "http_vm_names" {
  type    = set(string)
  default = ["http-vm-1", "http-vm-2"]
}

variable "db_vm_names" {
  type    = set(string)
  default = ["db-vm-1", "db-vm-2", "db-vm-3"]
}
