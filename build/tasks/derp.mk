DERP_TARGET_PACKAGE := $(PRODUCT_OUT)/DerpFest-$(DERP_VERSION).zip

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: derp bacon
derp: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(DERP_TARGET_PACKAGE)
	$(hide) $(MD5) $(DERP_TARGET_PACKAGE) | cut -d ' ' -f1 > $(DERP_TARGET_PACKAGE).md5sum
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}DerpFest ${txtrst}";
	@echo -e ""
	@echo -e ${CL_GRN}"█████▄ ▓█████  ██▀███   ██▓███    █████▒▓█████   ██████ ▄▄▄█████▓"
	@echo -e ${CL_GRN}"▒██▀ ██▌▓█   ▀ ▓██ ▒ ██▒▓██░  ██▒▓██   ▒ ▓█   ▀ ▒██    ▒ ▓  ██▒ ▓▒"
	@echo -e ${CL_GRN}"░██   █▌▒███   ▓██ ░▄█ ▒▓██░ ██▓▒▒████ ░ ▒███   ░ ▓██▄   ▒ ▓██░ ▒░"
	@echo -e ${CL_GRN}"░▓█▄   ▌▒▓█  ▄ ▒██▀▀█▄  ▒██▄█▓▒ ▒░▓█▒  ░ ▒▓█  ▄   ▒   ██▒░ ▓██▓ ░ "
	@echo -e ${CL_GRN}"░▒████▓ ░▒████▒░██▓ ▒██▒▒██▒ ░  ░░▒█░    ░▒████▒▒██████▒▒  ▒██▒ ░ "
	@echo -e ${CL_GRN}" ▒▒▓  ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░▒▓▒░ ░  ░ ▒ ░    ░░ ▒░ ░▒ ▒▓▒ ▒ ░  ▒ ░░   "
	@echo -e ${CL_GRN}" ░ ▒  ▒  ░ ░  ░  ░▒ ░ ▒░░▒ ░      ░       ░ ░  ░░ ░▒  ░ ░    ░    "
	@echo -e ${CL_GRN}" ░ ░  ░    ░     ░░   ░ ░░        ░ ░       ░   ░  ░  ░    ░      "
	@echo -e ""
	@echo -e "zip: "$(DERP_TARGET_PACKAGE)
	@echo -e "md5: `cat $(DERP_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"
	@echo -e "size:`ls -lah $(DERP_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: derp
