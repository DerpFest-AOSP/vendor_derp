$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit full common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/derp/overlay/dictionaries

$(call inherit-product, vendor/derp/config/telephony.mk)
