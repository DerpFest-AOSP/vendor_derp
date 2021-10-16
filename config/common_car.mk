# Inherit common DerpFest stuff
$(call inherit-product, vendor/derp/config/common.mk)

# Inherit DerpFest car device tree
$(call inherit-product, device/derp/car/derp_car.mk)

# Inherit the main AOSP car makefile that turns this into an Automotive build
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
