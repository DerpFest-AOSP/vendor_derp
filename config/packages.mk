# DerpFest packages
PRODUCT_PACKAGES += \
    BatteryStatsViewer \
    Datura \
    DerpSetupWizard \
    GameSpace \
    NetworkStackOverlay \
    NetworkStackMainlineOverlay \
    OmniStyle \
    Panic \
    ParallelSpace \
    Prospect \
    Ripple \
    TouchGestures \
    Updater

# Themes
PRODUCT_PACKAGES += \
    DerpThemesStub \
    DerpWalls \
    ThemePicker

# Udfps icons
PRODUCT_PACKAGES += \
    UdfpsIcons

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Extra tools in DerpFest
PRODUCT_PACKAGES += \
    bash \
    curl \
    getcap \
    htop \
    nano \
    setcap \
    vim

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

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
