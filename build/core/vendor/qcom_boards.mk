# Board platforms lists to be used for
# TARGET_BOARD_PLATFORM specific featurization

# Platform name variables - used in makefiles everywhere
MSMNILE := msmnile #SM8150
MSMSTEPPE := sm6150
TRINKET := trinket #SM6125

QCOM_BOARD_PLATFORMS += msm8998
QCOM_BOARD_PLATFORMS += sdm660

QCOM_BOARD_PLATFORMS += sdm710
QCOM_BOARD_PLATFORMS += sdm845

QCOM_BOARD_PLATFORMS += $(TRINKET)
QCOM_BOARD_PLATFORMS += $(MSMSTEPPE)
QCOM_BOARD_PLATFORMS += $(MSMNILE)
