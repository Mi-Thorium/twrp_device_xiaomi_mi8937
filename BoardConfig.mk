#
# Copyright (C) 2022 Team Win Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common mithorium-common
include device/xiaomi/mithorium-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/mi8937
USES_DEVICE_XIAOMI_MI8937 := true

# Kernel
ifeq ($(TARGET_KERNEL_VERSION),4.19)
TARGET_PREBUILT_KERNEL := device/xiaomi/kernel-mithorium/mi8937_4_19/Image.gz-dtb
else
TARGET_PREBUILT_KERNEL := device/xiaomi/kernel-mithorium/mi8937/Image.gz-dtb
endif

# Partitions
BOARD_USES_METADATA_PARTITION := true

# Partitions - dynamic
BOARD_SUPER_PARTITION_BLOCK_DEVICES := cust system
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE := 536870912
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 3221225472
BOARD_SUPER_PARTITION_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE) + $(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE) )

BOARD_SUPER_PARTITION_GROUPS := mi8937_dynpart
BOARD_MI8937_DYNPART_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304 )
BOARD_MI8937_DYNPART_PARTITION_LIST := system system_ext product vendor odm

# Ramdisk
BOARD_RECOVERYIMAGE_MAX_RAMDISK_SIZE := 20971520
BOARD_RAMDISK_USE_LZMA := true
LZMA_RAMDISK_TARGETS := recovery

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)
