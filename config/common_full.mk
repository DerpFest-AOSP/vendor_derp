# Inherit common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mobile.mk)

PRODUCT_SIZE := full

# Apps
PRODUCT_PACKAGES += \
    Symphonica \
    Flash

# Extra cmdline tools
PRODUCT_PACKAGES += \
    unrar \
    zstd

# Overlays
include vendor/overlay/overlays.mk

# Fonts
include vendor/fontage/config.mk
