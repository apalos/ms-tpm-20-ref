export V 			?= 0
export TA_CPU 			?= cortex-a9
export TA_CROSS_COMPILE 	?= /media/jbech/SSHD_LINUX/devel/optee_projects/reference/toolchains.gcc6/aarch32/bin/arm-linux-gnueabihf-
export TA_DEV_KIT_DIR 		?= /media/jbech/SSHD_LINUX/devel/optee_projects/qemu/optee_os/out/arm/export-ta_arm32
export CFG_TEE_TA_LOG_LEVEL 	?= 2

CROSS_COMPILE			?= /usr/bin/ccache $(TA_CROSS_COMPILE)

BINARY=bc50d971-d4c9-42c4-82cb-343fb7f37896

O ?= out
WOLF_ROOT := lib/external/wolfssl

include $(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk

clean: clean_stripped_file
.PHONY: clean_stripped_file
clean_stripped_file:
	rm -f $(BINARY).stripped.elf

