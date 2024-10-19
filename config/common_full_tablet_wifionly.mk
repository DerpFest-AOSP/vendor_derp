$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mobile full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile_full.mk)

# GMS
WITH_GMS := true
$(call inherit-product, vendor/google/gms/config.mk)
$(call inherit-product, vendor/google/pixel/config.mk)

# Inherit tablet common DerpFest stuff
$(call inherit-product, vendor/derp/config/tablet.mk)

$(call inherit-product, vendor/derp/config/wifionly.mk)
