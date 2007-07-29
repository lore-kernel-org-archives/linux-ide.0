From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/12] cs5530: add missing ->dma_base check
Date: Sun, 29 Jul 2007 19:50:49 +0200
Message-ID: <200707291950.49858.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:59072 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765347AbXG2SFR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945472ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


If ->dma_base is not set (== PCI BAR4 cannot be reserved) then DMA hooks
shouldn't be initialized or bad things will happen.

Also this host driver requires valid PCI BAR4 for normal operation so
check it in ->init_chipset and fail initialization if not set.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5530.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.73	Mar 10 2007
+ * linux/drivers/ide/pci/cs5530.c		Version 0.74	Jul 28 2007
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
@@ -164,6 +164,9 @@ static unsigned int __devinit init_chips
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
 	unsigned long flags;
 
+	if (pci_resource_start(dev, 4) == 0)
+		return -EFAULT;
+
 	dev = NULL;
 	while ((dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_ANY_ID, dev)) != NULL) {
 		switch (dev->device) {
@@ -282,6 +285,9 @@ static void __devinit init_hwif_cs5530 (
 			/* needs autotuning later */
 	}
 
+	if (hwif->dma_base == 0)
+		return;
+
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x07;
 	hwif->mwdma_mask = 0x07;
