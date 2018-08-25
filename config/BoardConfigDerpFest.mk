# Kernel
include vendor/derp/config/BoardConfigKernel.mk

# Qcom-specific bits
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/derp/config/BoardConfigQcom.mk
endif

# Soong
include vendor/derp/config/BoardConfigSoong.mk
