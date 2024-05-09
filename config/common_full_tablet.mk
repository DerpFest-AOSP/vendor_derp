$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/derp/overlay/dictionaries

# GMS
WITH_GMS := true
$(call inherit-product, vendor/gms/products/gms.mk)

# Pixel Framework
$(call inherit-product, vendor/pixel-framework/config.mk)

# Settings
PRODUCT_PRODUCT_PROPERTIES += \
    persist.settings.large_screen_opt.enabled=true

# Inherit from telephony config
$(call inherit-product, vendor/derp/config/telephony.mk)
