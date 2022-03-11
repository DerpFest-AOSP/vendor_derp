# Inherit mini common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME

$(call inherit-product, vendor/derp/config/telephony.mk)
