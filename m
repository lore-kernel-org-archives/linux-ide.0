From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/10] cmd64x: always set hwif->chipset for CMD646
Date: Tue, 11 Sep 2007 23:35:54 +0200
Message-ID: <200709112335.54396.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:27656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbXIKVkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:15 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1156nfb
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


hwif->chipset should be set to ide_cmd646 also when DMA base is invalid.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd64x.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -506,6 +506,9 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->set_pio_mode = &cmd64x_set_pio_mode;
 	hwif->set_dma_mode = &cmd64x_set_dma_mode;
 
+	if (dev->device == PCI_DEVICE_ID_CMD_646)
+		hwif->chipset = ide_cmd646;
+
 	if (!hwif->dma_base)
 		return;
 
@@ -535,7 +538,6 @@ static void __devinit init_hwif_cmd64x(i
 		hwif->ide_dma_test_irq	= &cmd648_ide_dma_test_irq;
 		break;
 	case PCI_DEVICE_ID_CMD_646:
-		hwif->chipset = ide_cmd646;
 		if (dev->revision == 0x01) {
 			hwif->ide_dma_end = &cmd646_1_ide_dma_end;
 			break;
