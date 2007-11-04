From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/18] pdc202xx_new: move PIO programming code to pdcnew_set_pio_mode()
Date: Mon, 5 Nov 2007 00:25:47 +0100
Message-ID: <200711050025.47116.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbXKDX3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:42 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219894nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Move PIO programming code from pdcnew_set_mode() to pdcnew_set_pio_mode().

* Rename pdcnew_set_mode() to pdcnew_set_dma_mode().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_new.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -146,7 +146,7 @@ static struct udma_timing {
 	{ 0x1a, 0x01, 0xcb },	/* UDMA mode 6 */
 };
 
-static void pdcnew_set_mode(ide_drive_t *drive, const u8 speed)
+static void pdcnew_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 adj			= (drive->dn & 1) ? 0x08 : 0x00;
@@ -177,7 +177,6 @@ static void pdcnew_set_mode(ide_drive_t 
 				set_indexed_reg(hwif, 0x12 + adj,
 						udma_timings[mode].reg12);
 				break;
-
 			case XFER_MW_DMA_2:
 			case XFER_MW_DMA_1:
 			case XFER_MW_DMA_0:
@@ -186,18 +185,6 @@ static void pdcnew_set_mode(ide_drive_t 
 				set_indexed_reg(hwif, 0x0f + adj,
 						mwdma_timings[mode].reg0f);
 				break;
-			case XFER_PIO_4:
-			case XFER_PIO_3:
-			case XFER_PIO_2:
-			case XFER_PIO_1:
-			case XFER_PIO_0:
-				set_indexed_reg(hwif, 0x0c + adj,
-						pio_timings[mode].reg0c);
-				set_indexed_reg(hwif, 0x0d + adj,
-						pio_timings[mode].reg0d);
-				set_indexed_reg(hwif, 0x13 + adj,
-						pio_timings[mode].reg13);
-				break;
 			default:
 				printk(KERN_ERR "pdc202xx_new: "
 				       "Unknown speed %d ignored\n", speed);
@@ -212,7 +199,14 @@ static void pdcnew_set_mode(ide_drive_t 
 
 static void pdcnew_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pdcnew_set_mode(drive, XFER_PIO_0 + pio);
+	ide_hwif_t *hwif = drive->hwif;
+	u8 adj = (drive->dn & 1) ? 0x08 : 0x00;
+
+	if (max_dma_rate(hwif->pci_dev) == 4) {
+		set_indexed_reg(hwif, 0x0c + adj, pio_timings[pio].reg0c);
+		set_indexed_reg(hwif, 0x0d + adj, pio_timings[pio].reg0d);
+		set_indexed_reg(hwif, 0x13 + adj, pio_timings[pio].reg13);
+	}
 }
 
 static u8 pdcnew_cable_detect(ide_hwif_t *hwif)
@@ -466,7 +460,7 @@ static unsigned int __devinit init_chips
 static void __devinit init_hwif_pdc202new(ide_hwif_t *hwif)
 {
 	hwif->set_pio_mode = &pdcnew_set_pio_mode;
-	hwif->set_dma_mode = &pdcnew_set_mode;
+	hwif->set_dma_mode = &pdcnew_set_dma_mode;
 
 	hwif->quirkproc = &pdcnew_quirkproc;
 	hwif->resetproc = &pdcnew_reset;
