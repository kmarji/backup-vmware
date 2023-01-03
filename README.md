# backup-vmware
a docker container to backup VMWare

to build the container run
```sh
docker build . -t backup-vm
```

To run the container
``` sh
docker run -e server=vcenter.domain.com \
           -e username=administrator@vsphere.loacl \
           -e password=StrongPassword \
           backup-vm
```

