#
# Copyright (C) 2022 Team Win Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_mi8937.mk

COMMON_LUNCH_CHOICES := \
    twrp_mi8937-user \
    twrp_mi8937-userdebug \
    twrp_mi8937-eng

PRODUCT_MAKEFILES += \
    $(LOCAL_DIR)/omni_mi8937.mk

COMMON_LUNCH_CHOICES += \
    omni_mi8937-user \
    omni_mi8937-userdebug \
    omni_mi8937-eng
