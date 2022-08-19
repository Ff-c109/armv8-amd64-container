echo "Preparing files"
mkdir installerCache || exit -1
echo "Downloading resource"
wget -c https://ff-c109.github.io/armv8-amd64-container/installer/ubuntu_amd64-res.apk
echo "Uncompressing resource"
cd installerCache || exit -1
unzip ../ubuntu_amd64-res.apk

echo 'Creating startup program'
echo "#! /bin/bash" > startUbuntu
echo '# ' >> startUbuntu
echo '###' >> startUbuntu
echo ' ' >> startUbuntu
echo 'cd ubuntu_amd64 || exit -1' >> startUbuntu
echo 'su -c "mount --bind /dev ./dev &&\' >> startUbuntu
echo 'mount --bind  /dev/pts ./dev/pts &&\' >> startUbuntu
echo 'mount -t proc /proc ./proc &&\' >> startUbuntu
echo 'mount --bind /etc/resolv.conf ./etc/resolv.conf &&\' >> startUbuntu
echo 'mount -t sysfs /sys ./sys &&\' >> startUbuntu
echo 'mount --bind /dev/shm  ./dev/shm"' >> startUbuntu
echo ' ' >> startUbuntu
echo 'su -c "chroot . bash"' >> startUbuntu
echo ' ' >> startUbuntu
echo 'exit 0' >> startUbuntu

echo 'Creating uninstall program'
echo '#! /bin/bash' > unins
echo 'su -c "ls &&\' >> unins
echo 'umount ubuntu_amd64/dev/pts &&\' >> unins
echo 'umount ubuntu_amd64/proc&&\' >> unins
echo 'umount ubuntu_amd64/etc/resolv.conf&&\' >> unins
echo 'umount ubuntu_amd64/sys&&\' >> unins
echo 'umount ubuntu_amd64/dev/shm&&\' >> unins
echo 'umount ubuntu_amd64/dev&&\' >> unins
echo 'rm -rf ubuntu_amd64"' >> unins
echo ' ' >> unins
echo 'xhost - 127.0.0.1' >> unins
echo 'rm -f *' >> unins


echo "Installing"
chmod +x startUbuntu
chmod +x unins

Target=`cat pth.tmp`
mv * $Target || exit -1
rm -rf ../installerCache
cd $Target || exit -1

echo 'Preparing for first startup'
bash setubuntu_amd64.bash || exit -1

