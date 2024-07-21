# Inherit mobile mini common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/derp/config/wifionly.mk)
