$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_full.mk)

# GMS
WITH_GMS := true
# Inherit from GMS product config
$(call inherit-product, vendor/gms/gms_full_tablet_wifionly.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include DerpFest LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/derp/overlay/dictionaries

# Settings
PRODUCT_PRODUCT_PROPERTIES += \
    persist.settings.large_screen_opt.enabled=true

$(call inherit-product, vendor/derp/config/wifionly.mk)
