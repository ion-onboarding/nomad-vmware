# vpshere one vm
No operating system added in the vm for simplicity.

## Before creating infrastructure
- adjust settings in file __main.tf__ for __vpshere__ provider

## Create infrastructure
- from main repo change directory into this example
```
cd 01-vm-basic
```
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
