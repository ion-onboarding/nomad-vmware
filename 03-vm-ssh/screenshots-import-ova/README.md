# Manual steps to import ubuntu cloud-image

[Link ubuntu cloud-images](https://cloud-images.ubuntu.com/)

- import OVA
    - select cluster
    - `ACTIONS` > `Deploy OVF Template...`

![](screenshots/01-import-ova.png)

- add OVA template
    - paste the ova download URL  and click next

![](screenshots/02-add-ova-url.png)

- name and folder
    - select the cluster
    - leave vm name as it is
    - click next

![](screenshots/03-name-folder.png)

- compute resource
    - select the cluster
    - click next

![](screenshots/04-compute-resource.png)

- review details
    - click next

![](screenshots/05-review-details.png)

- storage
    - select storage

![](screenshots/06-select-storage.png)

- network
    - leave the default `VM Network`
    - click next

![](screenshots/07-select-network.png)

- customize template
    - leave the defaults
    - click next

![](screenshots/08-customize-template.png)

- ready to complete
    - review and click finish

![](screenshots/09-ready-to-complete.png)


- check that the VM is ready
    - click on cluster > VMs

![](screenshots/10-check-vm-ready.png)