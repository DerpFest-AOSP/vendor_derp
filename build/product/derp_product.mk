#
# Copyright (C) 2020 Raphielscape LLC. and Haruka LLC.
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

# Includes all AOSP product packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_product.mk)

# All modules for telephony
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)

PRODUCT_PACKAGES := \
    audio.a2dp.default \
    libfwdlockengine \
    netutils-wrapper-1.0 \
    preinstalled-packages-platform-full-base.xml

PRODUCT_VENDOR_PROPERTIES := \
    keyguard.no_require_sim?=true \
    ro.com.android.dataroaming?=true

PRODUCT_COPY_FILES := \
    device/sample/etc/apns-full-conf.xml:system/etc/apns-conf.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# Put en_US first in the list, so make it default.
PRODUCT_LOCALES := en_US

# Get a list of languages.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Get everything else from the parent package
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)
