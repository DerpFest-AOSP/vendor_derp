# DerpFest required packages
PRODUCT_PACKAGES += \
    Launcher3 \
    Launcher3QuickStep \
    OmniJaws \
    OmniStyle \
    StitchImage \
    StitchImageService \
    ThemePicker \
    Updater

# Applications
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PartnerBookmarksProvider \
    PresencePolling \
    QuickAccessWallet \
    RcsService \
    SafetyRegulatoryInfo \
    SimpleDeviceConfig \
    Stk \
    TimeZoneUpdater

# Offline charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Extra tools in DerpFest
PRODUCT_PACKAGES += \
    7z \
    bash \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni
