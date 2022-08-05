#!/system/bin/sh

echo >> /system/etc/recovery.fstab
cat /system/etc/recovery.fstab.device >> /system/etc/recovery.fstab
echo >> /system/etc/twrp.flags
cat /system/etc/twrp.flags.device >> /system/etc/twrp.flags

# Decryption
mkdir /data || true
if mount -o ro /dev/block/bootdevice/by-name/userdata /data; then
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

# Dynamic Partitions
if dd if=/dev/block/by-name/system bs=256k count=1|strings|grep mi8937_dynpart > /dev/null; then
    echo >> /system/etc/recovery.fstab
    for p in system system_ext product vendor odm; do
        echo "${p} /${p} ext4 rw,barrier=1,discard wait,logical" >> /system/etc/recovery.fstab
    done
else
    echo >> /system/etc/twrp.flags
    cat /system/etc/twrp.flags.nondynpart >> /system/etc/twrp.flags
fi