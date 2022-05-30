resource "vsphere_tag_category" "terraform_project" {
  name        = "${var.main_project_tag}-${random_pet.name.id}"
  cardinality = "SINGLE"
  description = "Managed by Terraform"

  associable_types = [
    "VirtualMachine",
    "Datastore",
  ]
}

resource "vsphere_tag" "terraform_tag" {
  name        = "${var.main_project_tag}"
  category_id = "${vsphere_tag_category.terraform_project.id}"
  description = "Managed by Terraform"
}

resource "vsphere_folder" "vm" {
  path          = "terraform-vms-${random_pet.name.id}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_ovf_vm_template" "ovfRemote" {
  name              = "foo"
  disk_provisioning = "thin"
  resource_pool_id  = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id      = data.vsphere_datastore.datastore.id
  host_system_id    = data.vsphere_host.host.id
  remote_ovf_url    = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.ova"
  ovf_network_map = {
    "VM Network" : data.vsphere_network.network.id
  }
}

## Deployment of VM from OVA - https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine
resource "vsphere_virtual_machine" "vm" {
  count = var.vm_count
  name  = "vm-${random_pet.name.id}-${count.index}"

  datacenter_id        = data.vsphere_datacenter.datacenter.id
  datastore_id         = data.vsphere_datastore.datastore.id
  host_system_id       = data.vsphere_host.host.id                              # host system ID is required for ovf deployment
  resource_pool_id     = data.vsphere_compute_cluster.cluster.resource_pool_id

  num_cpus             = var.vm_cpus
  memory               = var.vm_memory
  guest_id             = data.vsphere_ovf_vm_template.ovfRemote.guest_id
  scsi_type            = data.vsphere_ovf_vm_template.ovfRemote.scsi_type

  dynamic "network_interface" {
    for_each = data.vsphere_ovf_vm_template.ovfRemote.ovf_network_map
    content {
      network_id = network_interface.value
    }
  }

  ovf_deploy {
    allow_unverified_ssl_cert = false
    remote_ovf_url            = data.vsphere_ovf_vm_template.ovfRemote.remote_ovf_url
    disk_provisioning         = data.vsphere_ovf_vm_template.ovfRemote.disk_provisioning
    ovf_network_map           = data.vsphere_ovf_vm_template.ovfRemote.ovf_network_map
  }

  cdrom {
    client_device = true # must be added for cloud-init to work
  }

  vapp {
    properties = {
      user-data = base64gzip(templatefile("${path.module}/cloud-init/userdata.yml", local.vm_vars))
    }
  }
}