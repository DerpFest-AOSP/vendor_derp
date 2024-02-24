# Inherit common mobile DerpFest stuff
$(call inherit-product, vendor/derp/config/common.mk)

# Include AOSP audio files
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage14.mk)
include vendor/derp/config/aosp_audio.mk

# Include DerpFest audio files
include vendor/derp/config/derp_audio.mk

# Default notification/alarm sounds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifeq ($(PRODUCT_TYPE), go)
PRODUCT_PACKAGES += \
    DerpLauncherQuickStepGo

PRODUCT_DEXPREOPT_SPEED_APPS += \
    DerpLauncherQuickStepGo
else
PRODUCT_PACKAGES += \
    DerpLauncherQuickStep

PRODUCT_DEXPREOPT_SPEED_APPS += \
    DerpLauncherQuickStep
endif

PRODUCT_PACKAGES += \
    DerpLauncherOverlay

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images \
    product_charger_res_images_vendor

# Customizations
PRODUCT_PACKAGES += \
    DisplayCutoutEmulationNarrowOverlay \
    DisplayCutoutEmulationWideOverlay \
    KeyboardNoNavigationBarOverlay \
    Launcher3NoHintOverlay \
    NoCutoutOverlay \
    NavigationBarMode2ButtonOverlay \
    NavigationBarNoHintOverlay

# Media
PRODUCT_SYSTEM_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet
