# vm & ssh details
- __vm is cloned from template__
- __ubuntu cloud-image .ova is imported manually__
- create a tag and attach to resources
- check locally for public key and upload to vm
- output connection details
- use count => more vms


## Before creating infrastructure
- from main repo change directory into this example
```
cd 03-vm-ssh
```
- configure __cloud-init/userdata.yml__,  check [examples on cloudinit.readthedocs.io](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)
- create a file __terraform.tfvars__ or remove `.example` from __terraform.tfvars.example__
    - add variables specific to your project
- import manually the ova of preference from [cloud-images.ubuntu.com](https://cloud-images.ubuntu.com), check as example `screenshots-import-ova`
- do NOT power on the after import

## Create infrastructure
- initialize working directory
```
terraform init
```
- plan, to see what resources will be created
```
terraform plan
```

- create resources
```
terraform apply
```

- destroy resources
```
terraform destroy
```

- what resources where created
```
terraform state list
```

- output connection details
```
terraform output
```