From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 00:50:03 +0300
Message-ID: <20070801215003.GA1864@nalle>
References: <20070801092903.GA1199@nalle> <200708012234.03375.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:60191 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbXHAVuJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 17:50:09 -0400
Content-Disposition: inline
In-Reply-To: <200708012234.03375.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Aug 01, 2007 at 10:34:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Could you try attached patch?
> 
> [PATCH] ide-disk: workaround for buggy HPA support on ST340823A

Umh, it's getting late but some makefile magic maybe missing, or I
should do a clean build?

$ make drivers/ide/ide-disk.ko V=1 
rm -f include/config/kernel.release
echo 2.6.22.1 > include/config/kernel.release
set -e; echo '  CHK     include/linux/version.h'; mkdir -p
include/linux/;     (echo \#define LINUX_VERSION_CODE 132630; echo
'#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';) <
/home/mcfrisk/src/linux/linux-2.6.22.1.new/Makefile >
include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp -s
include/linux/version.h include/linux/version.h.tmp; then rm -f
include/linux/version.h.tmp; else echo '  UPD
include/linux/version.h'; mv -f include/linux/version.h.tmp
include/linux/version.h; fi
  CHK     include/linux/version.h
set -e; echo '  CHK     include/linux/utsrelease.h'; mkdir -p
include/linux/;  if [ `echo -n "2.6.22.1" | wc -c ` -gt 64 ]; then echo
'"2.6.22.1" exceeds 64 characters' >&2; exit 1; fi; (echo \#define
UTS_RELEASE \"2.6.22.1\";) < include/config/kernel.release >
include/linux/utsrelease.h.tmp; if [ -r include/linux/utsrelease.h ] &&
cmp -s include/linux/utsrelease.h include/linux/utsrelease.h.tmp; then
rm -f include/linux/utsrelease.h.tmp; else echo '  UPD
include/linux/utsrelease.h'; mv -f include/linux/utsrelease.h.tmp
include/linux/utsrelease.h; fi
  CHK     include/linux/utsrelease.h
make -f scripts/Makefile.build obj=scripts/basic
make -f scripts/Makefile.build obj=.
mkdir -p arch/i386/kernel/
make -f scripts/Makefile.build obj=. missing-syscalls
  /bin/sh scripts/checksyscalls.sh gcc -m32
-Wp,-MD,./.missing-syscalls.d  -nostdinc -isystem
/usr/lib/gcc/i486-linux-gnu/4.1.3/include -D__KERNEL__ -Iinclude
-include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common -Os -pipe -msoft-float
-mregparm=3 -freg-struct-return -mpreferred-stack-boundary=2
-march=i486 -mtune=generic -ffreestanding -maccumulate-outgoing-args
-DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -g
-fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign
-D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(missing_syscalls)"
-D"KBUILD_MODNAME=KBUILD_STR(missing_syscalls)"
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/genksyms
make -f scripts/Makefile.build obj=scripts/mod
make KBUILD_MODULES=1   \
        -f scripts/Makefile.build obj=drivers/ide drivers/ide/ide-disk.o
make -f
/home/mcfrisk/src/linux/linux-2.6.22.1.new/scripts/Makefile.modpost
  scripts/mod/modpost -m  -o
/home/mcfrisk/src/linux/linux-2.6.22.1.new/Module.symvers
ERROR: "ide_in_drive_list" [drivers/ide/ide-disk.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [drivers/ide/ide-disk.ko] Error 2

Based on Alan's comments I'm already running 2.6.22.1 with this:

diff -ru linux-2.6.22.1/drivers/ide/ide-disk.c linux-2.6.22.1.new/drivers/ide/ide-disk.c
--- linux-2.6.22.1/drivers/ide/ide-disk.c	2007-07-10 21:56:30.000000000 +0300
+++ linux-2.6.22.1.new/drivers/ide/ide-disk.c	2007-08-01 22:59:47.000000000 +0300
@@ -502,6 +502,17 @@
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));
 
+	if ((set_max % 2) && (set_max == capacity + 1)) {
+		printk(KERN_INFO "Old drive detected, keeping current capacity.\n");
+		return;
+	}
+
 	if (lba48)
 		set_max = idedisk_set_max_address_ext(drive, set_max);
 	else


