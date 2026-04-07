# Custom security patch
CUSTOM_SECURITY_PATCH := 2026-04-01

# DerpFest specific props
ADDITIONAL_SYSTEM_PROPERTIES += \
    org.derpfest.build_security_patch=$(CUSTOM_SECURITY_PATCH)
