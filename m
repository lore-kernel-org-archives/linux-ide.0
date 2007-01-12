From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/19] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA
Date: Fri, 12 Jan 2007 05:27:10 +0100
Message-ID: <20070112042710.28794.40403.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030505AbXALEYQ@vger.kernel.org>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[PATCH] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA #ifdef-s

In drivers/ide/Kconfig BLK_DEV_TRM290 depends on
BLK_DEV_IDEDMA_PCI (on which is BLK_DEV_IDEDMA dependant on).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/trm290.c |    4 ----
 1 file changed, 4 deletions(-)

Index: a/drivers/ide/pci/trm290.c
===================================================================
--- a.orig/drivers/ide/pci/trm290.c
+++ a/drivers/ide/pci/trm290.c
@@ -177,7 +177,6 @@ static void trm290_selectproc (ide_drive
 	trm290_prepare_drive(drive, drive->using_dma);
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -242,7 +241,6 @@ static int trm290_ide_dma_test_irq (ide_
 	status = hwif->INW(hwif->dma_status);
 	return (status == 0x00ff);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 /*
  * Invoked from ide-dma.c at boot time.
@@ -289,13 +287,11 @@ static void __devinit init_hwif_trm290(i
 
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->dma_setup = &trm290_ide_dma_setup;
 	hwif->dma_exec_cmd = &trm290_ide_dma_exec_cmd;
 	hwif->dma_start = &trm290_ide_dma_start;
 	hwif->ide_dma_end = &trm290_ide_dma_end;
 	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 	hwif->selectproc = &trm290_selectproc;
 	hwif->autodma = 0;		/* play it safe for now */
