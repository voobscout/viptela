#!/usr/bin/env bash
DISKS=("b" "c" "d" "e" "f")
RAID=$(mdadm --detail --scan | awk '{print $2}')

_install_essentials() {
    local apps=("nfs-common" "mdadm" "parted")
    for i in ${apps[@]}; do
        [[ ! $(apt search $i | grep -i installed) ]] && apt -y install $i
    done
}

_mk_raid() {
    local md=(${md[@]})
    for i in "${DISKS[@]}"; do
        md=(${md[@]} /dev/sd$i)
    done
    mdadm --create --verbose --level=0 --metadata=1.2 --chunk=1024 --raid-devices=${#md[@]} /dev/md0 ${md[@]}
}

_rm_raid() {
    if [[ -n $RAID ]]; then
        mdadm --stop $RAID
        for i in "${DISKS[@]}"; do
            mdadm --misc --zero-superblock /dev/sd$i
        done
    fi
}

_install_essentials
[[ ! -n $RAID ]] && _mk_raid
