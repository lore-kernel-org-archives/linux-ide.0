From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/86] pata_atiixp: no need to program PIO timings for MWDMA
Date: Wed, 25 Nov 2009 18:03:23 +0100
Message-ID: <20091125170323.5446.6849.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759037AbZKYREF@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atiixp: no need to program PIO timings for MWDMA

Moreover the code to do it was buggy and programmed PIO timings
even if they were already set to a desired values.

There shouldn't be any problems with it as IDE atiixp host driver
has been allowing separate PIO/MWDMA timings for last two years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_atiixp.c |   15 ---------------
 1 file changed, 15 deletions(-)

Index: b/drivers/ata/pata_atiixp.c
===================================================================
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -107,7 +107,6 @@ static void atiixp_set_dmamode(struct at
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dma = adev->dma_mode;
 	int dn = 2 * ap->port_no + adev->devno;
-	int wanted_pio;
 
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		u16 udma_mode_data;
@@ -131,20 +130,6 @@ static void atiixp_set_dmamode(struct at
 		pci_write_config_dword(pdev, ATIIXP_IDE_MWDMA_TIMING,
 				       mwdma_timing_data);
 	}
-	/*
-	 *	We must now look at the PIO mode situation. We may need to
-	 *	adjust the PIO mode to keep the timings acceptable
-	 */
-	 if (adev->dma_mode >= XFER_MW_DMA_2)
-	 	wanted_pio = 4;
-	else if (adev->dma_mode == XFER_MW_DMA_1)
-		wanted_pio = 3;
-	else if (adev->dma_mode == XFER_MW_DMA_0)
-		wanted_pio = 0;
-	else BUG();
-
-	if (adev->pio_mode != wanted_pio)
-		atiixp_set_pio_timing(ap, adev, wanted_pio);
 }
 
 /**
