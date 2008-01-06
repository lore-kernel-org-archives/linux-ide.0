From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/8] ide: always set DMA masks in ide_pci_setup_ports()
Date: Sun, 06 Jan 2008 18:02:55 +0100
Message-ID: <20080106170255.6861.36960.sendpatchset@localhost.localdomain>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:19805 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757907AbYAFQvJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 11:51:09 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3036619ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2008 08:51:08 -0800 (PST)
In-Reply-To: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Always set DMA masks in ide_pci_setup_ports() to make sure that the valid
masks for a host are set.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
+34 bytes
 drivers/ide/setup-pci.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -556,10 +556,15 @@ void ide_pci_setup_ports(struct pci_dev 
 			hwif->drives[1].unmask = 1;
 		}
 
-		if (hwif->dma_base) {
-			hwif->swdma_mask = d->swdma_mask;
-			hwif->mwdma_mask = d->mwdma_mask;
-			hwif->ultra_mask = d->udma_mask;
+		hwif->swdma_mask = d->swdma_mask;
+		hwif->mwdma_mask = d->mwdma_mask;
+		hwif->ultra_mask = d->udma_mask;
+
+		if ((d->host_flags && IDE_HFLAG_NO_DMA) == 0 &&
+		    hwif->dma_base == 0) {
+			hwif->swdma_mask = 0;
+			hwif->mwdma_mask = 0;
+			hwif->ultra_mask = 0;
 		}
 
 		hwif->drives[0].autotune = 1;
