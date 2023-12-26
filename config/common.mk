# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= DerpFest

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_PROPERTIES += ro.adb.secure=1

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Backup Tool
ifneq ($(TARGET_EXCLUDE_BACKUPTOOL),true)
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/derp/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/derp/prebuilt/common/bin/50-derp.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-derp.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-derp.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/derp/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/derp/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh
endif
endif

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

# DerpFest-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/init/init.derp-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.derp-system_ext.rc

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/derp/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Support many users/work profiles
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.max_profiles=16 \
    fw.max_users=32

# Include AOSP audio files
include vendor/derp/config/aosp_audio.mk

# Include DerpFest audio files
include vendor/derp/config/derp_audio.mk

# Include extra packages
include vendor/derp/config/packages.mk

# Permissions for Google product apps
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/permissions/default-permissions-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default-permissions-product.xml

# Livedisplay
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/permissions/privapp-permissions-lineagehw.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-lineagehw.xml

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Disable iorapd
PRODUCT_SYSTEM_PROPERTIES += \
    ro.iorapd.enable=false

# Screen Resolution
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920

# Boot Animation
ifeq ($(USE_LEGACY_BOOTANIMATION), true)
PRODUCT_COPY_FILES += \
    vendor/derp/bootanimation/bootanimation_legacy.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/derp/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/init/init.derp-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.derp-updater.rc

PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Storage manager
PRODUCT_SYSTEM_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Blur
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
ifeq ($(TARGET_NOT_USES_BLUR),true)
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sysui.disableBlur=1
endif

# BtHelper
PRODUCT_PACKAGES += \
    BtHelper

# Root
PRODUCT_PACKAGES += \
    adb_root

# TextClassifier
PRODUCT_PACKAGES += \
    libtextclassifier_annotator_en_model \
    libtextclassifier_annotator_universal_model \
    libtextclassifier_actions_suggestions_universal_model \
    libtextclassifier_lang_id_model

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SettingsGoogle \
    SystemUIGoogle \
    DerpLauncher

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed

# Disable RescueParty due to high risk of data loss
PRODUCT_PRODUCT_PROPERTIES += \
	persist.sys.disable_rescue=true

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/derp/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/derp/overlay/common \
    vendor/derp/overlay/no-rro

-include $(WORKSPACE)/build_env/image-auto-bits.mk

# Art
include vendor/derp/config/art.mk

# Versioning
include vendor/derp/config/version.mk

# GApps
WITH_GMS := true
$(call inherit-product, vendor/gms/products/gms.mk)

# Pixel Framework
$(call inherit-product, vendor/pixel-framework/config.mk)

# Pixel customization
TARGET_SUPPORTS_GOOGLE_RECORDER ?= true
TARGET_INCLUDE_STOCK_ARCORE ?= true
TARGET_SUPPORTS_QUICK_TAP ?= true
TARGET_SUPPORTS_CALL_RECORDING ?= true
