$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mobile full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile_full.mk)

# GMS
WITH_GMS := true
# Inherit from GMS product config
$(call inherit-product, vendor/gms/gms_full_tablet_wifionly.mk)

# Pixel Framework
$(call inherit-product, vendor/pixel-framework/config.mk)

# Settings
PRODUCT_PRODUCT_PROPERTIES += \
    persist.settings.large_screen_opt.enabled=true

$(call inherit-product, vendor/derp/config/wifionly.mk)
