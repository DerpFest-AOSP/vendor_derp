# Inherit common DerpFest stuff
$(call inherit-product, vendor/derp/config/common.mk)

# Inherit DerpFest atv device tree
$(call inherit-product, device/derp/atv/derp_atv.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    LeanbackIME

PRODUCT_PACKAGE_OVERLAYS += vendor/derp/overlay/tv
