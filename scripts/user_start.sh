#!/usr/bin/env bash
_install_essentials() {
    local apps=("nfs-common" "mdadm" "parted")
    for i in ${apps[@]}; do
        [[ ! $(apt search $i | grep -i installed) ]] && apt -y install $i
    done
}

_mk_raid() {
    local disks=("b" "c" "d" "e" "f")
    local md=(${md[@]})
    for i in "${disks[@]}"; do
        mdadm --misc --zero-superblock /dev/sd$i
        echo "Done with /dev/sd$i"
        md=(${md[@]} /dev/sd$i)
    done
    mdadm --create --verbose --level=0 --metadata=1.2 --chunk=512 --raid-devices=${#md[@]} /dev/md0 ${md[@]}
}

_mount_nfs() {
    mkdir -p /opt/config_store
    mkdir -p /var/etcd/backups

    rpcbind
    # mount magrathea:/exports/config_store /opt/config_store
    # mount --rbind /opt/config_store/rancher/k8etcd.bkp /var/etcd/backups
}
_install_essentials
