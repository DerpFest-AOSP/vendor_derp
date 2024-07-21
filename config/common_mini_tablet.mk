# Inherit mobile mini common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile_mini.mk)

# Inherit tablet common DerpFest stuff
$(call inherit-product, vendor/derp/config/tablet.mk)

$(call inherit-product, vendor/derp/config/telephony.mk)
