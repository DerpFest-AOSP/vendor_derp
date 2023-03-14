$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mini common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
