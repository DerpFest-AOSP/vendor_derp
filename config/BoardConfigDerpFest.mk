# Safetynet
TARGET_FORCE_BUILD_FINGERPRINT := google/redfin/redfin:11/RQ1A.210205.004/7038034:user/release-keys

include vendor/derp/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/derp/config/BoardConfigQcom.mk
endif

include vendor/derp/config/BoardConfigSoong.mk
