# Manual steps to import ubuntu cloud-image

[Link ubuntu cloud-images](https://cloud-images.ubuntu.com/)

- import OVA
    - select cluster
    - `ACTIONS` > `Deploy OVF Template...`

![](screenshots/2022-05-21-00-54-44.png)

- add OVA template
    - paste the [URL](https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.ova) of the .ova and click next

![](screenshots/2022-05-21-00-56-15.png)

- name and folder
    - select the cluster
    - leave vm name as it is
    - click next

![](screenshots/2022-05-21-00-57-07.png)

- compute resource
    - select the cluster
    - click next

![](screenshots/2022-05-21-00-57-56.png)

- review details
    - click next

![](screenshots/2022-05-21-00-58-59.png)

- storage
    - select storage

![](screenshots/2022-05-21-01-00-46.png)

- network
    - leave the default `VM Network`
    - click next

![](screenshots/2022-05-21-01-01-22.png)

- customize template
    - leave the defaults
    - click next

![](screenshots/2022-05-21-01-02-11.png)

- ready to complete
    - review and click finish

![](screenshots/2022-05-21-01-03-14.png)


- check that the VM is ready
    - click on cluster > VMs

![](screenshots/2022-05-21-01-07-28.png)