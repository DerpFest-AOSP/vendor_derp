DERP_TARGET_PACKAGE := $(PRODUCT_OUT)/DerpFest-$(DERP_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: derp bacon
derp: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(DERP_TARGET_PACKAGE)
	$(hide) $(SHA256) $(DERP_TARGET_PACKAGE) | cut -d ' ' -f1 > $(DERP_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/derp/tools/generate_json_build_info.sh $(DERP_TARGET_PACKAGE)
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
	@echo -e "sha256: `cat $(DERP_TARGET_PACKAGE).sha256sum | cut -d ' ' -f 1`"
	@echo -e "size:`ls -lah $(DERP_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: derp
