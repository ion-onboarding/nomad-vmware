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

resource "vsphere_virtual_machine" "vm" {
  count = var.vm_count

  name             = "vm-${random_pet.name.id}-${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.vm.path # optional

  num_cpus = var.vm_cpus
  memory   = var.vm_memory

  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk_size
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
      user-data = base64gzip(templatefile("${path.module}/cloud-init/userdata.yml", local.vm_vars))
    }
  }

  tags = ["${vsphere_tag.terraform_tag.id}"]
}