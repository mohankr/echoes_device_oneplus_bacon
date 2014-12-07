#
# Copyright 2014 The Echoes Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

# Inherit from the common Open Source product configuration
#AOSP# $(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from bacon device
$(call inherit-product, device/oneplus/bacon/device.mk)

# Enhanced NFC
$(call inherit-product, vendor/echoes/config/nfc_enhanced.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/echoes/config/common_full_phone.mk)

PRODUCT_NAME := echoes_bacon
PRODUCT_DEVICE := bacon
PRODUCT_BRAND := oneplus
PRODUCT_MODEL := A0001
PRODUCT_MANUFACTURER := OnePlus

#AOSP# PRODUCT_RESTRICT_VENDOR_FILES := true

#AOSP# $(call inherit-product, device/moto/shamu/device.mk)
#AOSP# $(call inherit-product-if-exists, vendor/moto/shamu/device-vendor.mk)

#:#################################################################################
# CM - Extensions
PRODUCT_GMS_CLIENTID_BASE := android-oneplus

TARGET_VENDOR_PRODUCT_NAME := bacon
TARGET_VENDOR_DEVICE_NAME := A0001
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=A0001 PRODUCT_NAME=bacon

TARGET_CONTINUOUS_SPLASH_ENABLED := true

## Use the latest approved GMS identifiers unless running a signed build
ifneq ($(SIGN_BUILD),true)
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=oneplus/bacon/A0001:4.4.4/KTU84Q/XNPH44S:user/release-keys PRIVATE_BUILD_DESC="bacon-user 4.4.4 KTU84Q XNPH44S release-keys"
else
# Signed bacon gets a special boot animation because it's special.
PRODUCT_BOOTANIMATION := device/oneplus/bacon/bootanimation.zip
endif
#:#################################################################################
