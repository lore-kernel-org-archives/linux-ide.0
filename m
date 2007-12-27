From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] trm290: do hook dma_host_{on,off} methods (take 2)
Date: Thu, 27 Dec 2007 13:55:35 +0300
Message-ID: <200712271355.36105.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:26834 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751258AbXL0KzI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 05:55:08 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Using default methods caused the chip's DMA PRD count registers, inadvertently
starting DMA!  While fixing it, also do:

- get rid of the 'ide_' prefixes in several functions for which the prefix in
  the method's name has been 'ide_' ectomized already;

- align the code hooking the IDE DMA methods in init_hwif_trm290()...

---
Fixed the header, added 'static' to the new method definitions.
The patch is against Linus' kernel tree...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/trm290.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/ide/pci/trm290.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/trm290.c
+++ linux-2.6/drivers/ide/pci/trm290.c
@@ -1,7 +1,8 @@
 /*
- *  linux/drivers/ide/pci/trm290.c		Version 1.02	Mar. 18, 2000
+ *  linux/drivers/ide/pci/trm290.c		Version 1.05	Dec. 26, 2007
  *
  *  Copyright (c) 1997-1998  Mark Lord
+ *  Copyright (c) 2007       MontaVista Software, Inc. <source@mvista.com>
  *  May be copied or modified under the terms of the GNU General Public License
  *
  *  June 22, 2004 - get rid of check_region
@@ -177,7 +178,7 @@ static void trm290_selectproc (ide_drive
 	trm290_prepare_drive(drive, drive->using_dma);
 }
 
-static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
+static void trm290_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	BUG_ON(HWGROUP(drive)->handler != NULL);	/* paranoia check */
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
@@ -185,7 +186,7 @@ static void trm290_ide_dma_exec_cmd(ide_
 	outb(command, IDE_COMMAND_REG);
 }
 
-static int trm290_ide_dma_setup(ide_drive_t *drive)
+static int trm290_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->hwgroup->rq;
@@ -215,7 +216,7 @@ static int trm290_ide_dma_setup(ide_driv
 	return 0;
 }
 
-static void trm290_ide_dma_start(ide_drive_t *drive)
+static void trm290_dma_start(ide_drive_t *drive)
 {
 }
 
@@ -240,6 +241,14 @@ static int trm290_ide_dma_test_irq (ide_
 	return (status == 0x00ff);
 }
 
+static void trm290_dma_host_on(ide_drive_t *drive)
+{
+}
+
+static void trm290_dma_host_off(ide_drive_t *drive)
+{
+}
+
 static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
 	unsigned int cfgbase = 0;
@@ -280,11 +289,13 @@ static void __devinit init_hwif_trm290(i
 
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
 
-	hwif->dma_setup = &trm290_ide_dma_setup;
-	hwif->dma_exec_cmd = &trm290_ide_dma_exec_cmd;
-	hwif->dma_start = &trm290_ide_dma_start;
-	hwif->ide_dma_end = &trm290_ide_dma_end;
-	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
+	hwif->dma_host_off	= &trm290_dma_host_off;
+	hwif->dma_host_on	= &trm290_dma_host_on;
+	hwif->dma_setup 	= &trm290_dma_setup;
+	hwif->dma_exec_cmd	= &trm290_dma_exec_cmd;
+	hwif->dma_start 	= &trm290_dma_start;
+	hwif->ide_dma_end	= &trm290_ide_dma_end;
+	hwif->ide_dma_test_irq	= &trm290_ide_dma_test_irq;
 
 	hwif->selectproc = &trm290_selectproc;
 #if 1

