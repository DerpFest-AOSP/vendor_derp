# DerpFest packages
PRODUCT_PACKAGES += \
    DerpSetupWizard \
    GameSpace

# Updater
ifeq ($(DERP_BUILDTYPE), Official CI)
    PRODUCT_PACKAGES += \
        Updater
endif

# Themes
PRODUCT_PACKAGES += \
    DerpThemesStub \
    DerpWalls \
    ThemePicker

# Udfps
ifeq ($(EXTRA_UDFPS_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    UdfpsResources
endif

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Extra tools in DerpFest
PRODUCT_PACKAGES += \
    7z \
    bash \
    curl \
    getcap \
    htop \
    lib7z \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    zip

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync
