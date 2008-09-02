From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] ide: fix Makefile for ide-disk_proc
Date: Tue, 02 Sep 2008 11:44:54 -0700
Message-ID: <48BD89A6.1040200@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-next@vger.kernel.org
Cc: akpm <akpm@linux-foundation.org>, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix ide-disk_proc build error due to 2 entries in Makefile, one of them
being unconditional.

When CONFIG_IDE_PROC_FS=n, there are lots of errors/warnings:

linux-next-20080902/drivers/ide/ide-disk_proc.c:100: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ide_disk_proc'
linux-next-20080902/drivers/ide/ide-disk_proc.c:109: warning: data definition has no type or storage class
linux-next-20080902/drivers/ide/ide-disk_proc.c:109: warning: type defaults to 'int' in declaration of 'ide_devset_rw_field'
linux-next-20080902/drivers/ide/ide-disk_proc.c:109: warning: parameter names (without types) in function declaration
linux-next-20080902/drivers/ide/ide-disk_proc.c:110: warning: data definition has no type or storage class
linux-next-20080902/drivers/ide/ide-disk_proc.c:110: warning: type defaults to 'int' in declaration of 'ide_devset_rw_field'
linux-next-20080902/drivers/ide/ide-disk_proc.c:110: warning: parameter names (without types) in function declaration
linux-next-20080902/drivers/ide/ide-disk_proc.c:111: warning: data definition has no type or storage class
linux-next-20080902/drivers/ide/ide-disk_proc.c:111: warning: type defaults to 'int' in declaration of 'ide_devset_rw_field'
linux-next-20080902/drivers/ide/ide-disk_proc.c:111: warning: parameter names (without types) in function declaration
linux-next-20080902/drivers/ide/ide-disk_proc.c:112: warning: data definition has no type or storage class
linux-next-20080902/drivers/ide/ide-disk_proc.c:112: warning: type defaults to 'int' in declaration of 'ide_devset_rw_field'
linux-next-20080902/drivers/ide/ide-disk_proc.c:112: warning: parameter names (without types) in function declaration
linux-next-20080902/drivers/ide/ide-disk_proc.c:113: warning: data definition has no type or storage class
linux-next-20080902/drivers/ide/ide-disk_proc.c:113: warning: type defaults to 'int' in declaration of 'ide_devset_rw_field'
linux-next-20080902/drivers/ide/ide-disk_proc.c:113: warning: parameter names (without types) in function declaration
linux-next-20080902/drivers/ide/ide-disk_proc.c:114: warning: data definition has no type or storage class
linux-next-20080902/drivers/ide/ide-disk_proc.c:114: warning: type defaults to 'int' in declaration of 'ide_devset_rw_field'
linux-next-20080902/drivers/ide/ide-disk_proc.c:114: warning: parameter names (without types) in function declaration
linux-next-20080902/drivers/ide/ide-disk_proc.c:116: error: array type has incomplete element type
linux-next-20080902/drivers/ide/ide-disk_proc.c:117: error: implicit declaration of function 'IDE_PROC_DEVSET'
linux-next-20080902/drivers/ide/ide-disk_proc.c:117: error: 'acoustic' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:118: error: 'address' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:119: error: 'bios_cyl' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:120: error: 'bios_head' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:121: error: 'bios_sect' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:122: error: 'failures' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:123: error: 'lun' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:124: error: 'max_failures' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:125: error: 'multcount' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:126: error: 'nowerr' undeclared here (not in a function)
linux-next-20080902/drivers/ide/ide-disk_proc.c:127: error: 'wcache' undeclared here (not in a function)
make[3]: *** [drivers/ide/ide-disk_proc.o] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ide/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20080902.orig/drivers/ide/Makefile
+++ linux-next-20080902/drivers/ide/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_IDE_H8300)			+= h8300/
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
 obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
-ide-disk_mod-y += ide-disk.o ide-disk_ioctl.o ide-disk_proc.o
+ide-disk_mod-y += ide-disk.o ide-disk_ioctl.o
 ide-cd_mod-y += ide-cd.o ide-cd_ioctl.o ide-cd_verbose.o
 ide-floppy_mod-y += ide-floppy.o ide-floppy_ioctl.o
 
