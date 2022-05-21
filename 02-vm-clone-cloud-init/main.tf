provider "vsphere" {
  vsphere_server       = "2.3.4.5"
  user                 = "administrator@vsphere.local"
  password             = "<PASSWORD>"
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

# import ova first to use this block, see https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.ova
# do NOT power on after import 
data "vsphere_virtual_machine" "template" {
  name          = "focal-server-cloudimg-amd64"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# create a folder for VM - optional
resource "vsphere_folder" "vm" {
  path          = "terraform-${random_pet.name.id}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = random_pet.name.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.vm.path # optional

  num_cpus = 2
  memory   = 2048

  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  cdrom {
    client_device = true # must be added for cloud-init to work
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  vapp {
    properties = {
      user-data = base64gzip(templatefile("${path.module}/cloud-init/userdata.yml", {}))
    }
  }
}

# password set for ubuntu user through cloud-init/userdata.yml is: ubuntu
locals {
  SSH_vm = "ssh -o StrictHostKeyChecking=no ubuntu@${vsphere_virtual_machine.vm.default_ip_address}"
}
output "SSH_vm" {
  value = local.SSH_vm
}
