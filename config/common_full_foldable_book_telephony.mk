# Inherit mobile full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile_full.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# Inherit tablet common DerpFest stuff
$(call inherit-product, vendor/derp/config/tablet.mk)

$(call inherit-product, vendor/derp/config/telephony.mk)
