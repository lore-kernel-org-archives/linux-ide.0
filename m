From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/13] serverworks: cleanup ->set_dma_mode method
Date: Tue, 13 Nov 2007 00:01:16 +0100
Message-ID: <200711130001.16287.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:63392 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691AbXKLW6F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:05 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1250510nfb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


IDE core guarantees that ->set_dma_mode will be called only
for DMA modes set in SWDMA/MWDMA/UDMA masks.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/serverworks.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -164,25 +164,12 @@ static void svwks_set_dma_mode(ide_drive
 	ultra_timing	&= ~(0x0F << (4*unit));
 	ultra_enable	&= ~(0x01 << drive->dn);
 
-	switch(speed) {
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			dma_timing |= dma_modes[speed - XFER_MW_DMA_0];
-			break;
-
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			dma_timing   |= dma_modes[2];
-			ultra_timing |= ((udma_modes[speed - XFER_UDMA_0]) << (4*unit));
-			ultra_enable |= (0x01 << drive->dn);
-		default:
-			break;
-	}
+	if (speed >= XFER_UDMA_0) {
+		dma_timing   |= dma_modes[2];
+		ultra_timing |= (udma_modes[speed - XFER_UDMA_0] << (4 * unit));
+		ultra_enable |= (0x01 << drive->dn);
+	} else if (speed >= XFER_MW_DMA_0)
+		dma_timing   |= dma_modes[speed - XFER_MW_DMA_0];
 
 	pci_write_config_byte(dev, drive_pci2[drive->dn], dma_timing);
 	pci_write_config_byte(dev, (0x56|hwif->channel), ultra_timing);
