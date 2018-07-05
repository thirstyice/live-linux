#/bin/sh

echo "Device:"
read device

git pull --ff-only
if [[ $? == 0 ]]; then
echo "Version number:"
read version
if [[ $version != no ]]; then
echo "DISTRIB_ID=thirstyos
DISTRIB_DESCRIPTION=thirstyos $version
DISTRIB_RELEASE=$version
DISTRIB_CODENAME=$version">config/includes.chroot/etc/lsb-release
git add config/includes.chroot/etc/lsb-release
git commit -m "Updated version number in lsb-release to $version"
fi
sudo su -s /bin/bash -c "
echo \"

configuring\"
echo -e \"\e[96m\"
lb config --verbose;
echo -e \"\e[0m
config done, building
\e[95m\"; 
lb build --verbose; 
echo -e \"\e[0m
build done, clearing usb
\e[94m\"; 
dd if=/dev/zero of=$device bs=4M;
sync;
echo -e \"\e[0m
cleared, copying iso
\e[93m\"; 
dd if=live-image-amd64.hybrid.iso of=$device bs=4M; 
sync;
echo -e \"\e[0m
done!
\";
"

else
echo "Git pull failed; Merge then try again"
fi
