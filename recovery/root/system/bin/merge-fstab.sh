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