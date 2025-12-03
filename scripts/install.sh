#! /bin/sh

# This is an example configuration script.
# The script gets called with the environment variables from the install script
# (see install.sh) and these additional variables:
# OSI_USER_NAME          : User's name. Not ASCII-fied
# OSI_USER_USERNAME      : Linux username. ASCII-fied
# OSI_USER_AUTOLOGIN     : Whether to autologin the user
# OSI_USER_PASSWORD      : User's password. Can be empty if autologin is set.
# OSI_FORMATS            : Locale of formats to be used
# OSI_TIMEZONE           : Timezone to be used
# OSI_ADDITIONAL_SOFTWARE: Space-separated list of additional packages to install
# OSI_ADDITIONAL_FEATURES: Space-separated list of additional features chosen

# sanity check that all variables were set
if [ -z ${OSI_LOCALE+x} ] || \
   [ -z ${OSI_KEYBOARD_LAYOUT+x} ] || \
   [ -z ${OSI_DEVICE_PATH+x} ] || \
   [ -z ${OSI_DEVICE_IS_PARTITION+x} ] || \
   [ -z ${OSI_DEVICE_EFI_PARTITION+x} ] || \
   [ -z ${OSI_USE_ENCRYPTION+x} ] || \
   [ -z ${OSI_ENCRYPTION_PIN+x} ]
then
    echo "Installer script called without all environment variables set!"
    exit 1
fi

echo 'Installation started.'
echo ''
echo 'Variables set to:'
echo 'OSI_LOCALE               ' $OSI_LOCALE
echo 'OSI_KEYBOARD_LAYOUT      ' $OSI_KEYBOARD_LAYOUT
echo 'OSI_DEVICE_PATH          ' $OSI_DEVICE_PATH
echo 'OSI_DEVICE_IS_PARTITION  ' $OSI_DEVICE_IS_PARTITION
echo 'OSI_DEVICE_EFI_PARTITION ' $OSI_DEVICE_EFI_PARTITION
echo 'OSI_USE_ENCRYPTION       ' $OSI_USE_ENCRYPTION
echo 'OSI_ENCRYPTION_PIN       ' $OSI_ENCRYPTION_PIN
echo ''

bootc install to-disk --composefs-backend --source-imgref registry:ghcr.io/horizonlinux/horizon:latest --filesystem btrfs --wipe --bootloader systemd $OSI_DEVICE_PATH
sudo mount $OSI_DEVICE_PATH /mnt/sysroot
sudo cp -r /var/lib/flatpak /mnt/sysroot/state/os/default/var/lib/flatpak
sudo umount $OSI_DEVICE_PATH

echo

echo 'Installation complete!'

exit 0
