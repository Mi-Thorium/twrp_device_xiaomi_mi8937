#
# Copyright (C) 2022 Team Win Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common mithorium-common
include device/xiaomi/mithorium-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/uter

# Kernel
TARGET_PREBUILT_KERNEL := device/xiaomi/kernel-mithorium/uter/Image.gz-dtb

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)
