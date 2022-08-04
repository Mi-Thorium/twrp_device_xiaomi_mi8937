#
# Copyright (C) 2022 Team Win Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from uter device
$(call inherit-product, device/xiaomi/uter/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := uter
PRODUCT_NAME := twrp_uter
BOARD_VENDOR := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := UTER
PRODUCT_MANUFACTURER := Xiaomi
TARGET_VENDOR := Xiaomi
