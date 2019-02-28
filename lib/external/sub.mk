
WOLF_SSL_FLAGS = -DSINGLE_THREADED -DNO_WOLFSSL_CLIENT -DNO_WOLFSSL_SERVER -DOPENSSL_EXTRA -DNO_FILESYSTEM -DWOLFSSL_USER_SETTINGS -DTIME_OVERRIDES -DSTRING_USER -DCTYPE_USER

#
# Wolfcrypt has multiple unused functions, unfortunately the OPTEE build system can only turn off compiler flags for
# files in the same directory as the sub.mk file. It is not possible to place sub.mk files in the git submodules without
# creating a new fork of each submodule repo. To avoid spurious warnings these warnings are disabled here globally.
#

WOLF_WARNING_SUPPRESS = -Wno-unused-function

cflags-y += $(WOLF_SSL_FLAGS) $(WOLF_WARNING_SUPPRESS)

#
# For the purposes of this command the current working directory is the makefile root (/fTPM) folder,
# but the symlink will be created relative to THIS directory so the source requires an extra '../../'.
#
#./lib/wolf/wolf_symlink:
#	@echo Checking symlink to the WolfSSL folder: $(abspath $(WOLF_ROOT))
#	@if [ -L ./lib/wolf/wolf_symlink ] ; \
#	then \
#	echo Symlink already established ; \
#	else \
#	echo Establishing symlink. ; \
#	ln -s ../../$(WOLF_ROOT) ./lib/wolf/wolf_symlink; \
#	fi
#
#.PHONY: remove_wolf_symlink
#remove_wolf_symlink:
#	@if [ -e ./lib/wolf/wolf_symlink ] ; \
#	then \
#	unlink ./lib/wolf/wolf_symlink ; \
#	echo Clearing symlink to the Wolf folder: $(abspath $(WOLF_ROOT)) ; \
#	fi

global-incdirs-y += wolfssl

srcs-y += wolfssl/wolfcrypt/src/aes.c
srcs-y += wolfssl/wolfcrypt/src/asn.c
srcs-y += wolfssl/wolfcrypt/src/ecc.c
srcs-y += wolfssl/wolfcrypt/src/integer.c
srcs-y += wolfssl/wolfcrypt/src/memory.c
srcs-y += wolfssl/wolfcrypt/src/sha.c
srcs-y += wolfssl/wolfcrypt/src/sha256.c
srcs-y += wolfssl/wolfcrypt/src/sha512.c
srcs-y += wolfssl/wolfcrypt/src/tfm.c
srcs-y += wolfssl/wolfcrypt/src/wolfmath.c
srcs-y += wolfssl/wolfcrypt/src/des3.c
srcs-y += wolfssl/wolfcrypt/src/random.c
