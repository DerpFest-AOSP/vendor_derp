# Don't build debug for host or device
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
ART_BUILD_TARGET_NDEBUG := true
ART_BUILD_TARGET_DEBUG := false
ART_BUILD_HOST_NDEBUG := true
ART_BUILD_HOST_DEBUG := false
USE_DEX2OAT_DEBUG := false

ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
# Use 64-bit dex2oat for better dexopt time.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true
endif

# Dexopt profiles
profile_path := vendor/dexopt_profiles
ifneq ($(wildcard $(profile_path)),)
PRODUCT_DEX_PREOPT_PROFILE_DIR := $(profile_path)
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed-profile
endif
