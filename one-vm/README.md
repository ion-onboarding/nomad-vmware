# vpshere one virtual machine
- doesn't contain operating system

## Create infrastructure
- adjust settings in file __main.tf__ for provider `vpshere`
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