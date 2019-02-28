export V 			?= 0
export TA_CPU 			?= cortex-a9
export TA_CROSS_COMPILE 	?= /media/jbech/SSHD_LINUX/devel/optee_projects/reference/toolchains.gcc6/aarch32/bin/arm-linux-gnueabihf-
export TA_DEV_KIT_DIR 		?= /media/jbech/SSHD_LINUX/devel/optee_projects/qemu/optee_os/out/arm/export-ta_arm32
export CFG_TEE_TA_LOG_LEVEL 	?= 2

.PHONY: all
all:
	$(MAKE) -C fTPM CROSS_COMPILE=$(TA_CROSS_COMPILE)

.PHONY: clean
clean:
	$(MAKE) -C fTPM clean
