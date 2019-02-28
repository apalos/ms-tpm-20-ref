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
global-incdirs-y += op-tee/TPMCmd/Platform/include/
global-incdirs-y += op-tee/TPMCmd/Platform/include/prototypes/

# Files that comes from the MS 2.0 reference implementation but has been
# modified to work with OP-TEE. Note that we have removed the original files
# that otherwise would have been found under the same folder, but under
# 'lib/TPMCmd/... instead.
srcs-y += op-tee/TPMCmd/Platform/src/Cancel.c
srcs-y += op-tee/TPMCmd/Platform/src/Clock.c
srcs-y += op-tee/TPMCmd/Platform/src/Entropy.c
srcs-y += op-tee/TPMCmd/Platform/src/LocalityPlat.c
srcs-y += op-tee/TPMCmd/Platform/src/NVMem.c
srcs-y += op-tee/TPMCmd/Platform/src/PlatformData.c
srcs-y += op-tee/TPMCmd/Platform/src/PowerPlat.c
srcs-y += op-tee/TPMCmd/Platform/src/PPPlat.c
srcs-y += op-tee/TPMCmd/Platform/src/RunCommand.c
srcs-y += op-tee/TPMCmd/Platform/src/Unique.c

# Files that are unique to the OP-TEE implementation.
srcs-y += op-tee/AdminPPI.c
srcs-y += op-tee/EPS.c
srcs-y += op-tee/NvAdmin.c

srcs-y += reference/RuntimeSupport.c

srcs-y += fTPM.c
