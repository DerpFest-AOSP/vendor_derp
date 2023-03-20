# Inherit common mobile DerpFest stuff
$(call inherit-product, vendor/derp/config/common.mk)

# Default notification/alarm sounds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

# Apps
PRODUCT_PACKAGES += \
    Aperture \
    Eleven

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

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Customizations
PRODUCT_PACKAGES += \
    DisplayCutoutEmulationNarrowOverlay \
    DisplayCutoutEmulationWideOverlay \
    KeyboardNoNavigationBarOverlay \
    Launcher3NoHintOverlay \
    NoCutoutOverlay \
    NavigationBarNoHintOverlay

# DesktopMode
PRODUCT_PACKAGES += \
    DesktopMode

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml

$(call inherit-product, packages/services/VncFlinger/product.mk)

# Media
PRODUCT_SYSTEM_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet
