# Recovery
BOARD_USES_FULL_RECOVERY_IMAGE ?= true

include vendor/derp/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include hardware/qcom-caf/common/BoardConfigQcom.mk
endif

include vendor/derp/config/BoardConfigSoong.mk
