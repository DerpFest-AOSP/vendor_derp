# Copyright (C) 2016-2017 AOSiP
# Copyright (C) 2022 DerpFest
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
ifeq ($(DERP_VERSION_APPEND_TIME_OF_DAY),true)
    BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)
else
    BUILD_DATE := $(shell date -u +%Y%m%d)
endif

TARGET_PRODUCT_SHORT := $(subst derp_,,$(DERP_BUILDTYPE))

DERP_BUILDTYPE ?= Community
DERP_STATUS := Beta
DERP_BUILD_VERSION := $(PLATFORM_VERSION)
DERP_VERSION := $(DERP_BUILD_VERSION)-$(DERP_BUILDTYPE)-$(DERP_STATUS)-$(DERP_BUILD)-$(BUILD_DATE)
ROM_FINGERPRINT := DerpFest/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

ifeq ($(DERP_BUILDTYPE), CI)
    BUILD_KEYS := release-keys
endif

PRODUCT_SYSTEM_PROPERTIES += \
  ro.derp.build.version=$(DERP_BUILD_VERSION) \
  ro.derp.build.date=$(BUILD_DATE) \
  ro.derp.buildtype=$(DERP_BUILDTYPE) \
  ro.derp.fingerprint=$(ROM_FINGERPRINT) \
  ro.derp.version=$(DERP_VERSION) \
  ro.modversion=$(DERP_VERSION)

ifneq ($(OVERRIDE_OTA_CHANNEL),)
PRODUCT_SYSTEM_PROPERTIES += \
    derp.updater.uri=$(OVERRIDE_OTA_CHANNEL)
endif
