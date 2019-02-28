WARNS ?= 1
NOWERROR ?= 1
CFG_TA_DEBUG ?= 1
CFG_TEE_TA_LOG_LEVEL ?= 1

cflags-y += -DTHIRTY_TWO_BIT -DCFG_TEE_TA_LOG_LEVEL=$(CFG_TEE_TA_LOG_LEVEL) -D_ARM_ -w -Wno-strict-prototypes -mcpu=$(TA_CPU) -fstack-protector -Wstack-protector

ifeq ($(CFG_ARM64_ta_arm64),y)
cflags-y += -mstrict-align
else
cflags-y += -mno-unaligned-access
endif

ifeq ($(CFG_TA_DEBUG),y)
cflags-y += -DfTPMDebug=1
cflags-y += -DDBG=1
cflags-y += -O0
cflags-y += -DDEBUG
else
cflags-y += -Os
cflags-y += -DNDEBUG
endif

#
# Link the required external code into the libraries folder. OP-TEE build
# does not work well when accessing anything below the root directory. Use
# symlinks to trick it.
#
all: create_lib_symlinks
clean: clean_lib_symlinks

subdirs-y += lib

global-incdirs-y += include
global-incdirs-y += reference/include
global-incdirs-y += op-tee/include

srcs-y += op-tee/AdminPPI.c
srcs-y += op-tee/Cancel.c
srcs-y += op-tee/Clock.c
srcs-y += op-tee/Entropy.c
srcs-y += op-tee/LocalityPlat.c
srcs-y += op-tee/NvAdmin.c
srcs-y += op-tee/NVMem.c
srcs-y += op-tee/PowerPlat.c
srcs-y += op-tee/PlatformData.c
srcs-y += op-tee/PPPlat.c
srcs-y += op-tee/RunCommand.c
srcs-y += op-tee/Unique.c
srcs-y += op-tee/EPS.c
srcs-y += reference/RuntimeSupport.c

srcs-y += fTPM.c
