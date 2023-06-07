#!/system/bin/sh

if grep -F "Linux version 4.19" /proc/version > /dev/null; then
    KERNEL_VERSION="4.19"
fi

echo >> /system/etc/recovery.fstab
echo >> /system/etc/twrp.flags

if [ "$KERNEL_VERSION" == "4.19" ]; then
    cat /system/etc/recovery.fstab.fbev2 >> /system/etc/recovery.fstab
    cat /system/etc/twrp.flags.fbev2 >> /system/etc/twrp.flags
else
    cat /system/etc/recovery.fstab.fde >> /system/etc/recovery.fstab
    cat /system/etc/twrp.flags.fde >> /system/etc/twrp.flags
fi

BOOTDEVICE="$(getprop 'ro.boot.bootdevice')"

# Decryption
if [ "$KERNEL_VERSION" != "4.19" ]; then
    mkdir /data || true
    if mount -o ro /dev/block/platform/soc/${BOOTDEVICE}/by-name/userdata /data; then
        # Mounts successfully
        if [ -d '/data/media/0/Android' ]; then
            # Unencrypted
            sed -i 's|,encryptable=footer||g' /system/etc/recovery.fstab
            sed -i 's|encryptable=footer;||g' /system/etc/twrp.flags
        else
            # FBE
            sed -i 's|,encryptable=footer|,fileencryption=aes-256-xts|g' /system/etc/recovery.fstab
            sed -i 's|encryptable=footer;|fileencryption=aes-256-xts;|g' /system/etc/twrp.flags
        fi
        umount /data || true
    fi
fi

# Dynamic Partitions
if dd if=/dev/block/by-name/system bs=256k count=1|strings|grep mi8937_dynpart > /dev/null; then
    echo >> /system/etc/recovery.fstab
    for p in system system_ext product vendor odm; do
        echo "${p} /${p} ext4 rw,barrier=1,discard wait,logical" >> /system/etc/recovery.fstab
    done
    echo >> /system/etc/twrp.flags
    for p in cust; do
        echo "/super_${p} emmc /dev/block/by-name/${p} flags=display=\"Super_${p}\";backup=1" >> /system/etc/twrp.flags
    done
else
    echo >> /system/etc/twrp.flags
    cat /system/etc/twrp.flags.nondynpart >> /system/etc/twrp.flags
    echo "/super emmc /dev/block/by-name/system flags=display=\"Super\";backup=1" >> /system/etc/twrp.flags
    for p in cust; do
        echo "/super_${p} emmc /dev/block/by-name/${p} flags=display=\"Super_${p}\";backup=1" >> /system/etc/twrp.flags
    done
fi