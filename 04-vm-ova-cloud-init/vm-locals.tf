locals {
  public_key = fileexists("~/.ssh/id_ed25519.pub") ? file("~/.ssh/id_ed25519.pub") : file("~/.ssh/id_rsa.pub")

  vm_vars = {
    public_key = "${local.public_key}"
  }
}