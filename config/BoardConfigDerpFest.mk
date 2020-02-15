# Kernel
ifeq ($(LOCAL_KERNEL),)
include vendor/derp/config/BoardConfigKernel.mk
PRODUCT_SOONG_NAMESPACES += \
    vendor/derp/build/soong/generator
endif

# Qcom-specific bits
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/derp/config/BoardConfigQcom.mk
endif

# Soong
include vendor/derp/config/BoardConfigSoong.mk
