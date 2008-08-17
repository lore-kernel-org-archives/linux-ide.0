From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/9] ide: remove superfluous ->dma field from ide_hwif_t
Date: Sun, 17 Aug 2008 19:15:48 +0200
Message-ID: <20080817171548.27943.58522.sendpatchset@localhost.localdomain>
References: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:30252 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbYHQRSJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:18:09 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2799973mue.1
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:18:08 -0700 (PDT)
In-Reply-To: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c      |    2 --
 drivers/ide/pci/scc_pata.c |    2 --
 include/linux/ide.h        |    2 --
 3 files changed, 6 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -525,7 +525,6 @@ void ide_dma_start(ide_drive_t *drive)
 		outb(dma_cmd | 1, hwif->dma_base + ATA_DMA_CMD);
 	}
 
-	hwif->dma = 1;
 	wmb();
 }
 
@@ -564,7 +563,6 @@ int __ide_dma_end (ide_drive_t *drive)
 	/* purge DMA mappings */
 	ide_destroy_dmatable(drive);
 	/* verify good DMA status */
-	hwif->dma = 0;
 	wmb();
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
 }
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -353,7 +353,6 @@ static void scc_dma_start(ide_drive_t *d
 
 	/* start DMA */
 	scc_ide_outb(dma_cmd | 1, hwif->dma_base);
-	hwif->dma = 1;
 	wmb();
 }
 
@@ -374,7 +373,6 @@ static int __scc_dma_end(ide_drive_t *dr
 	/* purge DMA mappings */
 	ide_destroy_dmatable(drive);
 	/* verify good DMA status */
-	hwif->dma = 0;
 	wmb();
 	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
 }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -745,8 +745,6 @@ typedef struct hwif_s {
 
 	void		*hwif_data;	/* extra hwif data */
 
-	unsigned dma;
-
 #ifdef CONFIG_BLK_DEV_IDEACPI
 	struct ide_acpi_hwif_link *acpidata;
 #endif
