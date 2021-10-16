# Set DerpFest specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit mini common DerpFest stuff
$(call inherit-product, vendor/derp/config/common_mini_phone.mk)
