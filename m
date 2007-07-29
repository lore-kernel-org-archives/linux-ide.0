From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/12] triflex: add missing ->dma_base check
Date: Sun, 29 Jul 2007 19:53:32 +0200
Message-ID: <200707291953.32443.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:59804 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765488AbXG2SFW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945468ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


If ->dma_base is not set (== PCI BAR4 cannot be reserved) then DMA hooks
shouldn't be initialized or bad things will happen.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/triflex.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -111,6 +111,9 @@ static void __devinit init_hwif_triflex(
 	hwif->set_pio_mode = &triflex_set_pio_mode;
 	hwif->set_dma_mode = &triflex_set_mode;
 
+	if (hwif->dma_base == 0)
+		return;
+
 	hwif->atapi_dma  = 1;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
