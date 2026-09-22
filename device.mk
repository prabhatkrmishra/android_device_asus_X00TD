#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sdm660-common
$(call inherit-product, device/asus/sdm660-common/sdm660.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 2160
TARGET_SCREEN_WIDTH := 1080

# Fingerprint
PRODUCT_PACKAGES += \
    libhidlbase-v32.vendor

# Init
PRODUCT_PACKAGES += \
    init.device.rc

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Power
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Thermal configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf

# Wifi
PRODUCT_PACKAGES += \
    X00TDWifiOverlay

# Inherit the proprietary files
$(call inherit-product, vendor/asus/X00TD/X00TD-vendor.mk)

# Go-style memory savings, without low-RAM mode
# ro.config.low_ram stays unset - framework keeps full behavior
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
MALLOC_LOW_MEMORY := true

# Always preopt extracted APKs to prevent extracting out of the APK.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Dedupe VNDK libraries with identical core variants.
TARGET_VNDK_USE_CORE_VARIANT := true

# Cap MADV_WILLNEED readahead on odex/vdex to 30MB (down from the 100MB
# default) to alleviate pagecache pressure. Advisory prefetch only.
PRODUCT_PROPERTY_OVERRIDES +=     dalvik.vm.madvise.vdexfile.size=31457280     dalvik.vm.madvise.odexfile.size=31457280
