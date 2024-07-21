$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mobile full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile_full.mk)

# GMS
WITH_GMS := true
# Inherit from GMS product config
$(call inherit-product, vendor/gms/gms_full_tablet_wifionly.mk)

# Inherit full tablet common DerpFest stuff
$(call inherit-product, vendor/derp/config/full_tablet.mk)

$(call inherit-product, vendor/derp/config/wifionly.mk)
