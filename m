From: "Lothar Wassmann" <LW@KARO-electronics.de>
Subject: [PATCH] make ide driver compilable as kernel module (2.6.0)
Date: Thu, 8 Jan 2004 18:48:26 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <16381.38890.741153.45100@ipc1.karo>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.112.80.35] ([62.112.80.35]:33194 "EHLO ipc1.karo")
	by vger.kernel.org with ESMTP id S265669AbUAHRtE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2004 12:49:04 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, bkz@linux-ide.org

Hi,

the following patch enables building the ide driver as a kernel
module:
(BTW: the MAINTAINERS file lists 'B.Zolnierkiewicz@elka.pw.edu.pl' as
 the maintainers email address, while all the source files say: '<bkz@linux-ide.org>')
--- linux-2.6.0/drivers/block/ll_rw_blk.c	17 Dec 2003 16:48:21 -0000	1.1.1.3
+++ linux-2.6.0-rmk2-karo/drivers/block/ll_rw_blk.c	8 Jan 2004 14:48:36 -0000
@@ -144,6 +144,7 @@
 	q->activity_fn = fn;
 	q->activity_data = data;
 }
+EXPORT_SYMBOL(blk_queue_activity_fn);
 
 /**
  * blk_queue_prep_rq - set a prepare_request function for queue
--- linux-2.6.0/drivers/ide/Makefile	11 Nov 2003 11:09:10 -0000	1.1.1.2
+++ linux-2.6.0-rmk2-karo/drivers/ide/Makefile	8 Jan 2004 14:48:36 -0000
@@ -12,7 +12,8 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
+ide-mod-objs = ide-io.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-mod.o ide-probe.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
@@ -23,6 +24,9 @@
 obj-$(CONFIG_BLK_DEV_IDE_TCQ)		+= ide-tcq.o
 obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
+ifeq ($(CONFIG_BLK_DEV_IDE),m)
+ide-mod-objs				+= ide-proc.o
+endif
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
 obj-$(CONFIG_PROC_FS)			+= ide-proc.o
 endif
--- linux-2.6.0/drivers/ide/ide-default.c	21 Oct 2003 15:08:33 -0000	1.1.1.2
+++ linux-2.6.0-rmk2-karo/drivers/ide/ide-default.c	8 Jan 2004 14:48:36 -0000
@@ -48,6 +48,7 @@
 	.attach		=	idedefault_attach,
 	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
 };
+EXPORT_SYMBOL(idedefault_driver);
 
 static int idedefault_attach (ide_drive_t *drive)
 {
--- linux-2.6.0/drivers/ide/ide-io.c	21 Oct 2003 15:08:33 -0000	1.1.1.2
+++ linux-2.6.0-rmk2-karo/drivers/ide/ide-io.c	8 Jan 2004 14:48:36 -0000
@@ -975,6 +975,7 @@
 {
 	ide_do_request(q->queuedata, IDE_NO_IRQ);
 }
+EXPORT_SYMBOL(do_ide_request);
 
 /*
  * un-busy the hwgroup etc, and clear any pending DMA status. we want to
--- linux-2.6.0/drivers/ide/ide.c	21 Oct 2003 15:08:23 -0000	1.1.1.2
+++ linux-2.6.0-rmk2-karo/drivers/ide/ide.c	8 Jan 2004 14:48:36 -0000
@@ -176,6 +176,7 @@
 static int initializing;	/* set while initializing built-in drivers */
 
 DECLARE_MUTEX(ide_cfg_sem);
+EXPORT_SYMBOL(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
@@ -1436,6 +1437,7 @@
 	if (drive->media != ide_disk)
 		ide_add_setting(drive,	"ide-scsi",		SETTING_RW,					-1,		HDIO_SET_IDE_SCSI,		TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			ide_atapi_to_scsi);
 }
+EXPORT_SYMBOL(ide_add_generic_settings);
 
 /*
  * Delay for *at least* 50ms.  As we don't know how much time is left
