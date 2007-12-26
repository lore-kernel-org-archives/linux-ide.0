From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] trm290: do hook dma_host_{on,off} methods
Date: Wed, 26 Dec 2007 22:47:23 +0300
Message-ID: <200712262247.23255.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:25261 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751401AbXLZTqz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 14:46:55 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Those two methods were reading/writing TRM-290 config. register; luckily (?)
the writes only tried to change undefined bits.  While fixing this, also

- get rid of the 'ide_' prefixes in several functions for which the prefix has
  been ectomized before;

- align the code initializing methods in init_hwif_trm290()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/trm290.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/ide/pci/trm290.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/trm290.c
+++ linux-2.6/drivers/ide/pci/trm290.c
@@ -177,7 +177,7 @@ static void trm290_selectproc (ide_drive
 	trm290_prepare_drive(drive, drive->using_dma);
 }
 
-static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
+static void trm290_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	BUG_ON(HWGROUP(drive)->handler != NULL);	/* paranoia check */
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
@@ -185,7 +185,7 @@ static void trm290_ide_dma_exec_cmd(ide_
 	outb(command, IDE_COMMAND_REG);
 }
 
-static int trm290_ide_dma_setup(ide_drive_t *drive)
+static int trm290_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->hwgroup->rq;
@@ -215,7 +215,7 @@ static int trm290_ide_dma_setup(ide_driv
 	return 0;
 }
 
-static void trm290_ide_dma_start(ide_drive_t *drive)
+static void trm290_dma_start(ide_drive_t *drive)
 {
 }
 
@@ -240,6 +240,14 @@ static int trm290_ide_dma_test_irq (ide_
 	return (status == 0x00ff);
 }
 
+void trm290_dma_host_on (ide_drive_t *drive)
+{
+}
+
+void trm290_dma_host_off(ide_drive_t *drive)
+{
+}
+
 static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
 	unsigned int cfgbase = 0;
@@ -280,11 +288,13 @@ static void __devinit init_hwif_trm290(i
 
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

