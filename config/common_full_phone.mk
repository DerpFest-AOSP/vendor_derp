# Inherit mobile full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# UDFPS Animation effects
PRODUCT_PACKAGES += \
    UdfpsAnimations

# Include DerpFest LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/derp/overlay/dictionaries

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# GMS
WITH_GMS := true
# Inherit from GMS product config
ifeq ($(TARGET_USES_MINI_GAPPS),true)
$(call inherit-product, vendor/gms/gms_mini.mk)
else ifeq ($(TARGET_USES_PICO_GAPPS),true)
$(call inherit-product, vendor/gms/gms_pico.mk)
else
$(call inherit-product, vendor/gms/gms_full.mk)
endif

# Pixel Framework
$(call inherit-product, vendor/pixel-framework/config.mk)

# Inherit from telephony config
$(call inherit-product, vendor/derp/config/telephony.mk)
