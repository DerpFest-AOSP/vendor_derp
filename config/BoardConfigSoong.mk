PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += derpVarsPlugin

SOONG_CONFIG_derpVarsPlugin :=

define addVar
  SOONG_CONFIG_derpVarsPlugin += $(1)
  SOONG_CONFIG_derpVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += derpGlobalVars
SOONG_CONFIG_derpGlobalVars += \
    aapt_version_code \
    additional_gralloc_10_usage_bits \
    camera_override_format_from_reserved \
    gralloc_handle_has_custom_content_md_reserved_size \
    gralloc_handle_has_reserved_size \
    target_health_charging_control_charging_path \
    target_health_charging_control_charging_enabled \
    target_health_charging_control_charging_disabled \
    target_health_charging_control_deadline_path \
    target_health_charging_control_supports_bypass \
    target_health_charging_control_supports_deadline \
    target_health_charging_control_supports_toggle \
    target_init_vendor_lib \
    target_ld_shim_libs \
    target_libcameraservice_ext_lib \
    target_surfaceflinger_udfps_lib \
    target_trust_usb_control_path \
    target_trust_usb_control_enable \
    target_trust_usb_control_disable \
    uses_oplus_camera \
    uses_nothing_camera

SOONG_CONFIG_NAMESPACES += derpNvidiaVars
SOONG_CONFIG_derpNvidiaVars += \
    uses_nvidia_enhancements

SOONG_CONFIG_NAMESPACES += derpQcomVars
SOONG_CONFIG_derpQcomVars += \
    supports_extended_compress_format \
    uses_pre_uplink_features_netmgrd

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_derpQcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_derpGlobalVars_camera_override_format_from_reserved := $(TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED)
SOONG_CONFIG_derpGlobalVars_gralloc_handle_has_custom_content_md_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE)
SOONG_CONFIG_derpGlobalVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_derpGlobalVars_uses_oplus_camera := $(TARGET_USES_OPLUS_CAMERA)
SOONG_CONFIG_derpGlobalVars_uses_nothing_camera := $(TARGET_USES_NOTHING_CAMERA)
SOONG_CONFIG_derpNvidiaVars_uses_nvidia_enhancements := $(NV_ANDROID_FRAMEWORK_ENHANCEMENTS)
SOONG_CONFIG_derpQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_derpQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)

# Set default values
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED ?= false
TARGET_CAMERA_SERVICE_EXT_LIB ?= libcameraservice_ext_lib
TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED ?= 1
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED ?= 0
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS ?= true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE ?= false
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE ?= true
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib
TARGET_TRUST_USB_CONTROL_PATH ?= /proc/sys/kernel/deny_new_usb
TARGET_TRUST_USB_CONTROL_ENABLE ?= 1
TARGET_TRUST_USB_CONTROL_DISABLE ?= 0

# Soong value variables
SOONG_CONFIG_derpGlobalVars_aapt_version_code := $(shell date -u +%Y%m%d)
SOONG_CONFIG_derpGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_derpGlobalVars_target_health_charging_control_charging_path := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH)
SOONG_CONFIG_derpGlobalVars_target_health_charging_control_charging_enabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED)
SOONG_CONFIG_derpGlobalVars_target_health_charging_control_charging_disabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED)
SOONG_CONFIG_derpGlobalVars_target_health_charging_control_deadline_path := $(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH)
SOONG_CONFIG_derpGlobalVars_target_health_charging_control_supports_bypass := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS)
SOONG_CONFIG_derpGlobalVars_target_health_charging_control_supports_deadline := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE)
SOONG_CONFIG_derpGlobalVars_target_health_charging_control_supports_toggle := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE)
SOONG_CONFIG_derpGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_derpGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_derpGlobalVars_target_libcameraservice_ext_lib := $(TARGET_CAMERA_SERVICE_EXT_LIB)
SOONG_CONFIG_derpGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
SOONG_CONFIG_derpGlobalVars_target_trust_usb_control_path := $(TARGET_TRUST_USB_CONTROL_PATH)
SOONG_CONFIG_derpGlobalVars_target_trust_usb_control_enable := $(TARGET_TRUST_USB_CONTROL_ENABLE)
SOONG_CONFIG_derpGlobalVars_target_trust_usb_control_disable := $(TARGET_TRUST_USB_CONTROL_DISABLE)
ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_derpQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_derpQcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif
