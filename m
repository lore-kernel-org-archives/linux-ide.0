From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/18] sc1200: move DMA timings to timing tables
Date: Mon, 5 Nov 2007 00:32:30 +0100
Message-ID: <200711050032.30664.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:53675 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbXKDX3r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:47 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219918nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Based on pata_sc1200.c.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sc1200.c |   62 ++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -135,57 +135,29 @@ static void sc1200_set_dma_mode(ide_driv
 	unsigned short		pci_clock;
 	unsigned int		basereg = hwif->channel ? 0x50 : 0x40;
 
+	static const u32 udma_timing[3][3] = {
+		{ 0x00921250, 0x00911140, 0x00911030 },
+		{ 0x00932470, 0x00922260, 0x00922140 },
+		{ 0x009436a1, 0x00933481, 0x00923261 },
+	};
+
+	static const u32 mwdma_timing[3][3] = {
+		{ 0x00077771, 0x00012121, 0x00002020 },
+		{ 0x000bbbb2, 0x00024241, 0x00013131 },
+		{ 0x000ffff3, 0x00035352, 0x00015151 },
+	};
+
 	pci_clock = sc1200_get_pci_clock();
 
 	/*
 	 * Note that each DMA mode has several timings associated with it.
 	 * The correct timing depends on the fast PCI clock freq.
 	 */
-	timings = 0;
-	switch (mode) {
-		case XFER_UDMA_0:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings = 0x00921250;	break;
-				case PCI_CLK_48:	timings = 0x00932470;	break;
-				case PCI_CLK_66:	timings = 0x009436a1;	break;
-			}
-			break;
-		case XFER_UDMA_1:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings = 0x00911140;	break;
-				case PCI_CLK_48:	timings = 0x00922260;	break;
-				case PCI_CLK_66:	timings = 0x00933481;	break;
-			}
-			break;
-		case XFER_UDMA_2:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings = 0x00911030;	break;
-				case PCI_CLK_48:	timings = 0x00922140;	break;
-				case PCI_CLK_66:	timings = 0x00923261;	break;
-			}
-			break;
-		case XFER_MW_DMA_0:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings = 0x00077771;	break;
-				case PCI_CLK_48:	timings = 0x000bbbb2;	break;
-				case PCI_CLK_66:	timings = 0x000ffff3;	break;
-			}
-			break;
-		case XFER_MW_DMA_1:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings = 0x00012121;	break;
-				case PCI_CLK_48:	timings = 0x00024241;	break;
-				case PCI_CLK_66:	timings = 0x00035352;	break;
-			}
-			break;
-		case XFER_MW_DMA_2:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings = 0x00002020;	break;
-				case PCI_CLK_48:	timings = 0x00013131;	break;
-				case PCI_CLK_66:	timings = 0x00015151;	break;
-			}
-			break;
-	}
+
+	if (mode >= XFER_UDMA_0)
+		timings =  udma_timing[pci_clock][mode - XFER_UDMA_0];
+	else
+		timings = mwdma_timing[pci_clock][mode - XFER_MW_DMA_0];
 
 	if (unit == 0) {			/* are we configuring drive0? */
 		pci_read_config_dword(hwif->pci_dev, basereg+4, &reg);
