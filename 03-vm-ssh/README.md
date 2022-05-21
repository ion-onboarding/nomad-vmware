# vm & ssh details
- creates a vm with vpshere
- creates a tag and attaches it to resources
- checks for public key and uploads it to the machine
- outputs connection details
- uses count if more machines are needed


## Before creating infrastructure
- from main repo change directory into this example
```
cd 03-vm-ssh
```
- configure __cloud-init/userdata.yml__,  check [examples on cloudinit.readthedocs.io](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)
- adjust settings in file __terraform.tfvars__, check for reference __terraform.tfvars.example__
- import manually the [ova](https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.ova) from [cloud-images.ubuntu.com](https://cloud-images.ubuntu.com), check `screenshots-import-ova`
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