#
# Copyright (C) 2014 The Android Open Source Project
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
#

LOCAL_PATH := $(call my-dir)

common_cflags := \
    -std=c99 \
    -Os \
    -Wno-char-subscripts \
    -Wno-sign-compare \
    -Wno-string-plus-int \
    -Wno-uninitialized \
    -Wno-unused-parameter \
    -funsigned-char \
    -ffunction-sections -fdata-sections \
    -fno-asynchronous-unwind-tables \

toybox_upstream_version := $(shell grep -o 'TOYBOX_VERSION.*\".*\"' $(LOCAL_PATH)/main.c | cut -d'"' -f2)
toybox_sha := $(shell git -C $(LOCAL_PATH) rev-parse --short=12 HEAD 2>/dev/null)

toybox_version := $(toybox_upstream_version)-$(toybox_sha)-android
common_cflags += -DTOYBOX_VERSION='"$(toybox_version)"'

#
# To update:
#

#  git remote add toybox https://github.com/landley/toybox.git
#  git fetch toybox
#  git merge toybox/master
#  mm -j32
#  # (Make any necessary Android.mk changes and test the new toybox.)
#  repo upload .
#  git push aosp HEAD:refs/for/master  # Push to gerrit for review.
#  git push aosp HEAD:master  # Push directly, avoiding gerrit.
#
#  # Now commit any necessary Android.mk changes like normal:
#  repo start post-sync .
#  git commit -a


#
# To add a toy:
#

#  make menuconfig
#  # (Select the toy you want to add.)
#  make clean && make  # Regenerate the generated files.
#  # Edit LOCAL_SRC_FILES below to add the toy.
#  # If you just want to use it as "toybox x" rather than "x", you can stop now.
#  # If you want this toy to have a symbolic link in /system/bin, add the toy to ALL_TOOLS.

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    lib/args.c \
    lib/dirtree.c \
    lib/getmountlist.c \
    lib/help.c \
    lib/interestingtimes.c \
    lib/lib.c \
    lib/linestack.c \
    lib/llist.c \
    lib/net.c \
    lib/password.c \
    lib/portability.c \
    lib/xwrap.c \
    main.c \
    toys/android/getenforce.c \
    toys/android/getprop.c \
    toys/android/load_policy.c \
    toys/android/restorecon.c \
    toys/android/runcon.c \
    toys/android/setenforce.c \
    toys/android/setprop.c \
    toys/lsb/dmesg.c \
    toys/lsb/hostname.c \
    toys/lsb/killall.c \
    toys/lsb/md5sum.c \
    toys/lsb/mknod.c \
    toys/lsb/mktemp.c \
    toys/lsb/mount.c \
    toys/lsb/pidof.c \
    toys/lsb/seq.c \
    toys/lsb/sync.c \
    toys/lsb/umount.c \
    toys/other/acpi.c \
    toys/other/base64.c \
    toys/other/blkid.c \
    toys/other/blockdev.c \
    toys/other/bzcat.c \
    toys/other/chcon.c \
    toys/other/chroot.c \
    toys/other/clear.c \
    toys/other/dos2unix.c \
    toys/other/fallocate.c \
    toys/other/flock.c \
    toys/other/free.c \
    toys/other/freeramdisk.c \
    toys/other/fsfreeze.c \
    toys/other/help.c \
    toys/other/hwclock.c \
    toys/other/ifconfig.c \
    toys/other/inotifyd.c \
    toys/other/insmod.c \
    toys/other/ionice.c \
    toys/other/losetup.c \
    toys/other/lsattr.c \
    toys/other/lsmod.c \
    toys/other/lspci.c \
    toys/other/lsusb.c \
    toys/other/makedevs.c \
    toys/other/mkswap.c \
    toys/other/modinfo.c \
    toys/other/mountpoint.c \
    toys/other/nbd_client.c \
    toys/other/netcat.c \
    toys/other/partprobe.c \
    toys/other/pivot_root.c \
    toys/other/pmap.c \
    toys/other/printenv.c \
    toys/other/pwdx.c \
    toys/other/readahead.c \
    toys/other/readlink.c \
    toys/other/realpath.c \
    toys/other/reset.c \
    toys/other/rev.c \
    toys/other/rfkill.c \
    toys/other/rmmod.c \
    toys/other/setsid.c \
    toys/other/stat.c \
    toys/other/swapoff.c \
    toys/other/swapon.c \
    toys/other/sysctl.c \
    toys/other/tac.c \
    toys/other/taskset.c \
    toys/other/timeout.c \
    toys/other/truncate.c \
    toys/other/uptime.c \
    toys/other/usleep.c \
    toys/other/vconfig.c \
    toys/other/vmstat.c \
    toys/other/which.c \
    toys/other/xxd.c \
    toys/other/yes.c \
    toys/pending/arp.c \
    toys/pending/dd.c \
    toys/pending/diff.c \
    toys/pending/expr.c \
    toys/pending/fdisk.c \
    toys/pending/file.c \
    toys/pending/ftpget.c \
    toys/pending/host.c \
    toys/pending/lsof.c \
    toys/pending/more.c \
    toys/pending/netstat.c \
    toys/pending/resize.c \
    toys/pending/route.c \
    toys/pending/tar.c \
    toys/pending/telnet.c \
    toys/pending/test.c \
    toys/pending/tr.c \
    toys/pending/traceroute.c \
    toys/pending/watch.c \
    toys/pending/xzcat.c \
    toys/posix/basename.c \
    toys/posix/cal.c \
    toys/posix/cat.c \
    toys/posix/chgrp.c \
    toys/posix/chmod.c \
    toys/posix/cksum.c \
    toys/posix/cmp.c \
    toys/posix/comm.c \
    toys/posix/cp.c \
    toys/posix/cpio.c \
    toys/posix/cut.c \
    toys/posix/date.c \
    toys/posix/df.c \
    toys/posix/dirname.c \
    toys/posix/du.c \
    toys/posix/echo.c \
    toys/posix/env.c \
    toys/posix/expand.c \
    toys/posix/false.c \
    toys/posix/find.c \
    toys/posix/grep.c \
    toys/posix/head.c \
    toys/posix/id.c \
    toys/posix/kill.c \
    toys/posix/ln.c \
    toys/posix/ls.c \
    toys/posix/mkdir.c \
    toys/posix/mkfifo.c \
    toys/posix/nice.c \
    toys/posix/nl.c \
    toys/posix/nohup.c \
    toys/posix/od.c \
    toys/posix/paste.c \
    toys/posix/patch.c \
    toys/posix/printf.c \
    toys/posix/ps.c \
    toys/posix/pwd.c \
    toys/posix/renice.c \
    toys/posix/rm.c \
    toys/posix/rmdir.c \
    toys/posix/sed.c \
    toys/posix/sleep.c \
    toys/posix/sort.c \
    toys/posix/split.c \
    toys/posix/strings.c \
    toys/posix/tail.c \
    toys/posix/tee.c \
    toys/posix/time.c \
    toys/posix/touch.c \
    toys/posix/true.c \
    toys/posix/tty.c \
    toys/posix/ulimit.c \
    toys/posix/uname.c \
    toys/posix/uniq.c \
    toys/posix/wc.c \
    toys/posix/xargs.c

LOCAL_CFLAGS := $(common_cflags)
LOCAL_CLANG := true

# This doesn't actually prevent us from dragging in libc++ at runtime
# because libnetd_client.so is C++.
LOCAL_CXX_STL := none

LOCAL_C_INCLUDES += bionic/libc/dns/include

LOCAL_MODULE := libtoybox

include $(BUILD_STATIC_LIBRARY)


# Host binary to enumerate the toys
include $(CLEAR_VARS)
LOCAL_SRC_FILES := scripts/install.c
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := $(common_cflags)
LOCAL_CLANG := true
LOCAL_MODULE := toybox-instlist
include $(BUILD_HOST_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_SRC_FILES := main.c
LOCAL_STATIC_LIBRARIES := libtoybox
LOCAL_SHARED_LIBRARIES := libcutils libselinux
LOCAL_CFLAGS := $(common_cflags)
LOCAL_CXX_STL := none
LOCAL_CLANG := true
LOCAL_MODULE := toybox

# for dumping the list of toys
TOYBOX_INSTLIST := $(HOST_OUT_EXECUTABLES)/toybox-instlist
LOCAL_ADDITIONAL_DEPENDENCIES := $(TOYBOX_INSTLIST)

# we still want a link for ls/ps, but the toolbox version needs to
# stick around for compatibility reasons, for now.
TOYS_FOR_XBIN := ls ps

# skip links for these toys in the system image, they already have
# a full-blown counterpart. we still want them for the recovery
# image though.
TOYS_WITHOUT_LINKS := blkid traceroute6

LOCAL_POST_INSTALL_CMD := $(hide) \
	echo "Generate Toybox links:" $$($(TOYBOX_INSTLIST)); \
	$(TOYBOX_INSTLIST) | grep -vFx -f <(tr ' ' '\n' <<< '$(TOYS_FOR_XBIN) $(TOYS_WITHOUT_LINKS)') | xargs -I'{}' ln -sf toybox '$(TARGET_OUT_EXECUTABLES)/{}'

include $(BUILD_EXECUTABLE)

# This is used by the recovery system
include $(CLEAR_VARS)
LOCAL_SRC_FILES := main.c
LOCAL_WHOLE_STATIC_LIBRARIES := libtoybox
LOCAL_CFLAGS := $(common_cflags)
LOCAL_CFLAGS += -Dmain=toybox_driver
LOCAL_CXX_STL := none
LOCAL_CLANG := true
LOCAL_MODULE := libtoybox_driver
include $(BUILD_STATIC_LIBRARY)

# static executable for use in limited environments
include $(CLEAR_VARS)
LOCAL_SRC_FILES := main.c
LOCAL_CFLAGS := $(common_cflags)
LOCAL_CXX_STL := none
LOCAL_CLANG := true
LOCAL_UNSTRIPPED_PATH := $(PRODUCT_OUT)/symbols/utilities
LOCAL_MODULE := toybox_static
LOCAL_MODULE_CLASS := UTILITY_EXECUTABLES
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/utilities
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_STEM := toybox
LOCAL_STATIC_LIBRARIES := libc libtoybox libcutils libselinux libmincrypt liblog
LOCAL_FORCE_STATIC_EXECUTABLE := true
include $(BUILD_EXECUTABLE)
