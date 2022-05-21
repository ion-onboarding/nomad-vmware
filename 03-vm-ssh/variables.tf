# # tag that will be attached to all resources
variable "main_project_tag" {}

# provider vars
variable "vsphere_username" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_insecure" {}

# datacenter specific
variable "vsphere_datacenter" {}
variable "vsphere_network" {}
variable "vsphere_cluster" {}
variable "vsphere_datastore" {}

# template to clone
variable "vsphere_vm_template" {}

# vm specific
variable "vm_count" {}
variable "vm_cpus" {}
variable "vm_memory" {}
variable "vm_disk_size" {}
