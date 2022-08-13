mkdir ubuntu_amd64
tar -zxvf ubuntu-base-22.04-base-amd64.tar.gz -C ubuntu_amd64 || exit 1
cp ./qemu-x86_64-static ubuntu_amd64/usr/bin || exit 1

cd ubuntu_amd64

su -c 'mount --bind /dev ./dev &&\
mount --bind  /dev/pts ./dev/pts &&\
mount -t proc /proc ./proc &&\
mount --bind /etc/resolv.conf ./etc/resolv.conf &&\
mount -t sysfs /sys ./sys &&\
mount --bind /dev/shm  ./dev/shm &&\
cp ../qemu-x86_64-static /usr/bin -n &&\
chown root:root ./root' || exit -1

xhost + 
xhost + 127.0.0.1
xhost + ::1

su -c 'chroot . arch &&\
chroot . whoami &&\
chroot . chmod +x /usr/bin/qemu-x86_64-static &&\
chroot . bash'

