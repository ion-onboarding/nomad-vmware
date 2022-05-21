# vm clone & cloud-init

## Before creating infrastructure
- adjust settings in file __main.tf__ for __vpshere__ provider
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
