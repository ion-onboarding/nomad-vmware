# password set for ubuntu user through cloud-init/userdata.yml is: ubuntu
locals {
  private_key = fileexists("~/.ssh/id_ed25519") ? "~/.ssh/id_ed25519" : "~/.ssh/id_rsa"
  SSH_vm      = [for vm in vsphere_virtual_machine.vm : " ssh -i ${local.private_key} -o StrictHostKeyChecking=no ubuntu@${vm.default_ip_address} "]
}
output "SSH_vm" {
  value = local.SSH_vm
}