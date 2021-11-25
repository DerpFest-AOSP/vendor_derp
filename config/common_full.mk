# Inherit common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile.mk)

PRODUCT_SIZE := full

# Fonts
PRODUCT_PACKAGES += \
    fonts_customization.xml

# RRO Overlays
PRODUCT_PACKAGES += \
    NavigationBarModeGesturalOverlayFS

# Overlays
include vendor/overlay/overlays.mk
