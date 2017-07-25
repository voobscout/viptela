FROM voobscout/base-arch:xorg-dummy
MAINTAINER Voobscout <voobscout@archlinux.info>

USER root
WORKDIR /root
# add BlackArch repos:
RUN curl https://blackarch.org/strap.sh > /tmp/ba_repo && \
    chmod 0755 /tmp/ba_repo && \
    sed -i 's/get_mirror$/# get_mirrors/g' /tmp/ba_repo && \
    /tmp/ba_repo && \
    sudo find /var/cache/pacman/pkg -mindepth 1 -delete

RUN runuser -l dev -c 'yaourt --aur --noconfirm --needed -Syyu && \
                         yaourt --aur --noconfirm --needed -S \
                         xfce4 \
                         xfce4-goodies \
                         terminator \
                         wireshark-gtk \
                         wireshark-cli \
                         gtkglext \
                         putty \
                         umit \
                         tigervnc \
                         x11vnc \
                         chromium \
                         firefox \
                         libreoffice-fresh \
                         teleport \
                         iproute2'

ADD https://raw.githubusercontent.com/voobscout/viptela/master/resources/xvnc.service /usr/lib/systemd/system/xvnc.service

RUN systemctl enable teleport.service && \
    systemctl enable xvnc.service
