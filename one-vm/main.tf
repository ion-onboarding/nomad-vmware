provider "vsphere" {
  vsphere_server       = "2.3.4.5"
  user                 = "administrator@vsphere.local"
  password             = "<USE-YOUR-PASSWORD>"
  allow_unverified_ssl = true
}

resource "random_pet" "name" {
  prefix = "vm"
  length = 2
}

data "vsphere_datacenter" "datacenter" {
  name = "dc-01"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "cluster-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# create a folder for VM - optional
resource "vsphere_folder" "vm" {
  path          = "terraform-${random_pet.name.id}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine
resource "vsphere_virtual_machine" "vm" {
  name             = "${random_pet.name.id}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.vm.path # optional

  num_cpus         = 1
  memory           = 1024
  guest_id         = "other3xLinux64Guest"

  wait_for_guest_net_timeout = 0 # don't wait for network
  wait_for_guest_ip_timeout  = 0 # don't wait for ip

  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
}