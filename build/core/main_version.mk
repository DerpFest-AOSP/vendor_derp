# Custom security patch
CUSTOM_SECURITY_PATCH := 2022-08-05

# DerpFest Android 12L Specific Props
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.derp.settings.android_version=12L \
    org.derpfest.build_security_patch=$(CUSTOM_SECURITY_PATCH)
