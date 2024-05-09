# Inherit full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_full.mk)

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
$(call inherit-product, vendor/gms/products/gms.mk)

# Pixel Framework
$(call inherit-product, vendor/pixel-framework/config.mk)

# Inherit from telephony config
$(call inherit-product, vendor/derp/config/telephony.mk)
