From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/5] ide: remove PIO "downgrade" quirk
Date: Sun, 17 Feb 2008 19:51:05 +0100
Message-ID: <20080217185105.16210.26582.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:63272 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbYBQSge (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 13:36:34 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1438294fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 10:36:31 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

No need for it nowadays so remove quirk code from ide_get_best_pio_mode()
and IDE_HFLAG_PIO_DOWNGRADE host flag.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c       |   10 ----------
 drivers/ide/pci/amd74xx.c   |    1 -
 drivers/ide/pci/via82cxxx.c |    1 -
 drivers/ide/ppc/pmac.c      |    1 -
 include/linux/ide.h         |    2 --
 5 files changed, 15 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -284,16 +284,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 		if (overridden)
 			printk(KERN_INFO "%s: tPIO > 2, assuming tPIO = 2\n",
 					 drive->name);
-
-		/*
-		 * Conservative "downgrade" for all pre-ATA2 drives
-		 */
-		if ((drive->hwif->host_flags & IDE_HFLAG_PIO_NO_DOWNGRADE) == 0 &&
-		    pio_mode && pio_mode < 4) {
-			pio_mode--;
-			printk(KERN_INFO "%s: applying conservative "
-					 "PIO \"downgrade\"\n", drive->name);
-		}
 	}
 
 	if (pio_mode > max_mode)
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -219,7 +219,6 @@ static void __devinit init_hwif_amd74xx(
 
 #define IDE_HFLAGS_AMD \
 	(IDE_HFLAG_PIO_NO_BLACKLIST | \
-	 IDE_HFLAG_PIO_NO_DOWNGRADE | \
 	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
 	 IDE_HFLAG_POST_SET_MODE | \
 	 IDE_HFLAG_IO_32BIT | \
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -429,7 +429,6 @@ static const struct ide_port_info via82c
 	.init_hwif	= init_hwif_via82cxxx,
 	.enablebits	= { { 0x40, 0x02, 0x02 }, { 0x40, 0x01, 0x01 } },
 	.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST |
-			  IDE_HFLAG_PIO_NO_DOWNGRADE |
 			  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 			  IDE_HFLAG_POST_SET_MODE |
 			  IDE_HFLAG_IO_32BIT,
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -921,7 +921,6 @@ pmac_ide_do_resume(ide_hwif_t *hwif)
 static const struct ide_port_info pmac_port_info = {
 	.chipset		= ide_pmac,
 	.host_flags		= IDE_HFLAG_SET_PIO_MODE_KEEP_DMA |
-				  IDE_HFLAG_PIO_NO_DOWNGRADE |
 				  IDE_HFLAG_POST_SET_MODE |
 				  IDE_HFLAG_NO_DMA | /* no SFF-style DMA */
 				  IDE_HFLAG_UNMASK_IRQS,
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1031,8 +1031,6 @@ enum {
 	IDE_HFLAG_SINGLE		= (1 << 1),
 	/* don't use legacy PIO blacklist */
 	IDE_HFLAG_PIO_NO_BLACKLIST	= (1 << 2),
-	/* don't use conservative PIO "downgrade" */
-	IDE_HFLAG_PIO_NO_DOWNGRADE	= (1 << 3),
 	/* use PIO8/9 for prefetch off/on */
 	IDE_HFLAG_ABUSE_PREFETCH	= (1 << 4),
 	/* use PIO6/7 for fast-devsel off/on */
