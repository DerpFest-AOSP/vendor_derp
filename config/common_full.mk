# Inherit common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile.mk)

PRODUCT_SIZE := full

# Overlays
include vendor/overlay/overlays.mk

# Extra cmdline tools
PRODUCT_PACKAGES += \
    unrar \
    zstd

# Fonts
include vendor/fontage/config.mk
