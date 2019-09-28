# Platform names
MSMNILE := msmnile #SM8150
MSMSTEPPE := sm6150
TRINKET := trinket #SM6125

UM_4_4_FAMILY := msm8998 sdm660
UM_4_9_FAMILY := sdm845 sdm710
UM_4_14_FAMILY := $(MSMNILE) $(MSMSTEPPE) $(TRINKET)
UM_PLATFORMS := $(UM_4_4_FAMILY) $(UM_4_9_FAMILY) $(UM_4_14_FAMILY)

BOARD_USES_ADRENO := true

# Tell HALs that we're compiling an AOSP build with an in-line kernel
TARGET_COMPILE_WITH_MSM_KERNEL := true

# Enable media extensions
TARGET_USES_MEDIA_EXTENSIONS := true

# Allow building audio encoders
TARGET_USES_QCOM_MM_AUDIO := true

# Enable color metadata for every UM platform
TARGET_USES_COLOR_METADATA := true

# Enable DRM PP driver on UM platforms that support it
ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_USES_DRM_PP := true
endif

# Mark GRALLOC_USAGE_HW_2D, GRALLOC_USAGE_EXTERNAL_DISP and GRALLOC_USAGE_PRIVATE_WFD as valid gralloc bits
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 10)
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 13)
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 21)

# Mark GRALLOC_USAGE_PRIVATE_HEIF_VIDEO as valid gralloc bits on UM platforms that support it
ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 27)
endif

# List of targets that use master side content protection
MASTER_SIDE_CP_TARGET_LIST := msm8996 $(UM_4_4_FAMILY) $(UM_4_9_FAMILY) $(UM_4_14_FAMILY)

ifneq ($(filter $(UM_4_4_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    MSM_VIDC_TARGET_LIST := $(UM_4_4_FAMILY)
    QCOM_HARDWARE_VARIANT := msm8998
else ifneq ($(filter $(UM_4_9_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    MSM_VIDC_TARGET_LIST := $(UM_4_9_FAMILY)
    QCOM_HARDWARE_VARIANT := sdm845
else ifneq ($(filter $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    MSM_VIDC_TARGET_LIST := $(UM_4_14_FAMILY)
    QCOM_HARDWARE_VARIANT := sm8150
else
    MSM_VIDC_TARGET_LIST := $(TARGET_BOARD_PLATFORM)
    QCOM_HARDWARE_VARIANT := $(TARGET_BOARD_PLATFORM)
endif

# Allow a device to manually override which HALs it wants to use
ifneq ($(OVERRIDE_QCOM_HARDWARE_VARIANT),)
    QCOM_HARDWARE_VARIANT := $(OVERRIDE_QCOM_HARDWARE_VARIANT)
endif

PRODUCT_SOONG_NAMESPACES += \
    hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)

# QCOM HW crypto
ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
    TARGET_CRYPTFS_HW_PATH ?= vendor/qcom/opensource/cryptfs_hw
endif
