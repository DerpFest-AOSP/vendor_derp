PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    keyguard.no_require_sim=true \
    media.recorder.show_manufacturer_and_model=true \
    net.tethering.noprovisioning=true \
    persist.sys.disable_rescue=true \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.config.bt_sco_vol_steps=30 \
    ro.config.media_vol_steps=30 \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.storage_manager.enabled=true \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Extra packages
PRODUCT_PACKAGES += \
    libjni_latinimegoogle

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/bin/backuptool.sh:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.sh \
    vendor/derp/prebuilt/common/bin/backuptool.functions:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.functions \
    vendor/derp/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/derp/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/derp/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/derp/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip

# Blur
ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/derp/config/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Configs
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/sysconfig/derp-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/derp-power-whitelist.xml \
    vendor/derp/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml \
    vendor/derp/prebuilt/common/etc/sysconfig/turbo.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/turbo.xml

# Copy all DerpFest-specific init rc files
$(foreach f,$(wildcard vendor/derp/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    NexusLauncherRelease \
    SystemUI

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED := false
ifneq ($(TARGET_DISABLE_ALTERNATIVE_FACE_UNLOCK), true)
PRODUCT_PACKAGES += \
    FaceUnlockService
TARGET_FACE_UNLOCK_SUPPORTED := true
endif
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.moto_unlock_service=$(TARGET_FACE_UNLOCK_SUPPORTED)

# Don't include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Permissions
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/permissions/privapp-permissions-derp-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-derp.xml \
    vendor/derp/prebuilt/common/etc/permissions/privapp-permissions-derp.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-derp.xml \
    vendor/derp/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml

# Pixel APNs
PRODUCT_COPY_FILES += \
	vendor/derp/prebuilt/common/etc/apns-full-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml

# Fonts to copy
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/fonts/fonts_shishufied.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml \
    vendor/derp/prebuilt/fonts/gobold/Gobold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gobold.ttf \
    vendor/derp/prebuilt/fonts/gobold/Gobold-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gobold-Italic.ttf \
    vendor/derp/prebuilt/fonts/gobold/GoboldBold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldBold.ttf \
    vendor/derp/prebuilt/fonts/gobold/GoboldBold-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldBold-Italic.ttf \
    vendor/derp/prebuilt/fonts/gobold/GoboldThinLight.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldThinLight.ttf \
    vendor/derp/prebuilt/fonts/gobold/GoboldThinLight-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldThinLight-Italic.ttf \
    vendor/derp/prebuilt/fonts/roadrage/road_rage.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/RoadRage-Regular.ttf \
    vendor/derp/prebuilt/fonts/snowstorm/snowstorm.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Snowstorm-Regular.ttf \
    vendor/derp/prebuilt/fonts/slate/SlateForOnePlus-Book.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SlateForOnePlus-Book.ttf \
    vendor/derp/prebuilt/fonts/slate/SlateForOnePlus-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SlateForOnePlus-Medium.ttf \
    vendor/derp/prebuilt/fonts/slate/SlateForOnePlus-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SlateForOnePlus-Regular.ttf \
    vendor/derp/prebuilt/fonts/tinkerbell/GearTinkerbell.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GearTinkerbell.ttf \
    vendor/derp/prebuilt/fonts/vcrosd/vcr_osd_mono.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ThemeableClock-vcrosd.ttf \
    vendor/derp/prebuilt/fonts/googlesans/GoogleSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/googlesans/GoogleSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontage/AdamCGPro-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AdamCGPro-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/AlexanaNeue-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AlexanaNeue-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/AlienLeague-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AlienLeague-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Azedo-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Azedo-Light.ttf \
    vendor/derp/prebuilt/fonts/fontage/BigNoodleTilting-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/BigNoodleTilting-Italic.ttf \
    vendor/derp/prebuilt/fonts/fontage/BigNoodleTilting-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/BigNoodleTilting-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Biko-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Biko-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Blern-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Blern-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/CoCoBiker-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/CoCoBiker-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Fester-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Fester-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontage/GinoraSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GinoraSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Inkferno-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Inkferno-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Instruction-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Instruction-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/JackLane-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/JackLane-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Metropolis1920-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Metropolis1920-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Monad-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Monad-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Neoneon-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Neoneon-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Noir-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Noir-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/North-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/North-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/OutrunFuture-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OutrunFuture-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Qontra-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Qontra-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Riviera-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Riviera-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/FoxAndCat-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ThemeableDate-fc.ttf \
    vendor/derp/prebuilt/fonts/fontage/FoxAndCat-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ThemeableOwner-fc.ttf \
    vendor/derp/prebuilt/fonts/fontage/TheOutbox-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/TheOutbox-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontage/Union-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Union-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Abel-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Abel-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/AdventPro-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AdventPro-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/ArchivoNarrow-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ArchivoNarrow-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/AutourOne-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AutourOne-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Bariol-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Bariol-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/BadScript-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/BadScript-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/CherrySwash-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/CherrySwash-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Codystar.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Codystar.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/din1451alt.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/din1451alt.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Hanken-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Hanken-Light.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/IBMPlexMono.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/IBMPlexMono.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/IBMPlexMono-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/IBMPlexMono-Light.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Jura-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Jura-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/KellySlab-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/KellySlab-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Pompiere-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Pompiere-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Raleway-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Raleway-Light.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/ReemKufi-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ReemKufi-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Satisfy-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Satisfy-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/SeaweedScript-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SeaweedScript-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/SedgwickAveDisplay-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SedgwickAveDisplay-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Vibur.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Vibur.ttf \
    vendor/derp/prebuilt/fonts/fontagev2/Voltaire.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Voltaire.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/AuthenticSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AuthenticSans-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/AuthenticSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AuthenticSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/ComicNeue-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ComicNeue-Bold.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/ComicNeue-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ComicNeue-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Decalotype-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Decalotype-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Decalotype-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Decalotype-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Exo2-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Exo2-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Exo2-SemiBold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Exo2-SemiBold.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/FantasqueMono-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/FantasqueMono-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Fleuron-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Fleuron-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Finlandica-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Finlandica-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Gothamono-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gothamono-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Gravity-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gravity-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/IgnazioText-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/IgnazioText-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Inter-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Inter-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Inter-MediumItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Inter-MediumItalic.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/JakartaPlus-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/JakartaPlus-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/JakartaPlus-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/JakartaPlus-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/LeagueMono-RegularNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-RegularNarrow.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/LeagueMono-MediumNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-MediumNarrow.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/LeagueMono-BoldNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-BoldNarrow.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/LeagueMono-SemiBoldNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-SemiBoldNarrow.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/LeonSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeonSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Lumie-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lumie-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/mescla_regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/mescla_regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Millimetre-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Millimetre-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Now-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Now-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Now-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Now-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/OdibeeSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OdibeeSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/OpenSauceSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OpenSauceSans-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/OpenSauceSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OpenSauceSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Panamericana-Display.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Panamericana-Display.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/PTSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/PTSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/PTMono-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/PTMono-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/QTVagaRound-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/QTVagaRound-Bold.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/QTVagaRound-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/QTVagaRound-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/routed-gothic-narrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/routed-gothic-narrow.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/routed-gothic-narrow-half-italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/routed-gothic-narrow-half-italic.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Scientifica-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Scientifica-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/SofiaSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSans-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/SofiaSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSans-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/SofiaSansSemiCond-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSansSemiCond-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/SofiaSansSemiCond-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSansSemiCond-Medium.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Universalis-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Universalis-Bold.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Universalis-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Universalis-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/UniversalisCond-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/UniversalisCond-Bold.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/UniversalisCond-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/UniversalisCond-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/VG5000-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/VG5000-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Vladisvostok-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Vladisvostok-Regular.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Volte-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Volte-Bold.ttf \
    vendor/derp/prebuilt/fonts/fontagev3/Volte-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Volte-Medium.ttf

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/derp/prebuilt/common/etc/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/derp/overlay

# Ignore overlays on RRO builds
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    packages/overlays/Shishufied/Overlays

# Apex
ifeq ($(TARGET_FLATTEN_APEX),false)
$(call inherit-product, vendor/derp/config/apex.mk)
else
# Hide "Google Play System Updates" if Apex disabled
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/derp/overlay_apex_disabled

DEVICE_PACKAGE_OVERLAYS += \
    vendor/derp/overlay_apex_disabled/common
endif

# Inherit from audio config
$(call inherit-product, vendor/derp/config/audio.mk)

# Inherit from packages config
$(call inherit-product, vendor/derp/config/packages.mk)

# Inherit from rro_overlays config
$(call inherit-product, vendor/derp/config/rro_overlays.mk)

# Call the overlays folder to build all the rest
include packages/overlays/Shishufied/shishu.mk

# Inherit from sepolicy config
$(call inherit-product, vendor/derp/config/sepolicy.mk)

# Inherit from textclassifier config
$(call inherit-product, vendor/derp/config/textclassifier.mk)

# Inherit from our versioning
$(call inherit-product, vendor/derp/config/versioning.mk)

# Inherit from GMS product config
$(call inherit-product, vendor/gms/gms_full.mk)

# Inherit from telephony config
$(call inherit-product, vendor/derp/config/telephony.mk)
