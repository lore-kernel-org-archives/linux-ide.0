From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] alim15x3: use ->host_flags and ->udma_mask fields from ide_pci_device_t
Date: Mon, 17 Sep 2007 22:07:35 +0200
Message-ID: <200709172207.35179.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:10981 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbXIQUIU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 16:08:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1419915wxd
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 13:08:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Make a local copy of ali15x3_chipset in alim15x3_init_one() and set
  ->host_flags / ->udma_mask according to the controller capabilities.

* Cleanup init_hwif_common_ali15x3().

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   49 +++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/alim15x3.c		Version 0.28	Sep 15 2007
+ * linux/drivers/ide/pci/alim15x3.c		Version 0.29	Sep 16 2007
  *
  *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
  *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
@@ -666,31 +666,9 @@ static void __devinit init_hwif_common_a
 	hwif->set_dma_mode = &ali_set_dma_mode;
 	hwif->udma_filter = &ali_udma_filter;
 
-	/* don't use LBA48 DMA on ALi devices before rev 0xC5 */
-	if (m5229_revision <= 0xC4)
-		hwif->host_flags |= IDE_HFLAG_NO_LBA48_DMA;
-
 	if (hwif->dma_base == 0)
 		return;
 
-	/*
-	 * check in ->init_dma guarantees m5229_revision >= 0x20 here
-	 */
-
-	if (m5229_revision == 0x20)
-		hwif->host_flags |= IDE_HFLAG_NO_ATAPI_DMA;
-
-	if (m5229_revision <= 0x20)
-		hwif->ultra_mask = 0x00; /* no udma */
-	else if (m5229_revision < 0xC2)
-		hwif->ultra_mask = ATA_UDMA2;
-	else if (m5229_revision == 0xC2 || m5229_revision == 0xC3)
-		hwif->ultra_mask = ATA_UDMA4;
-	else if (m5229_revision == 0xC4)
-		hwif->ultra_mask = ATA_UDMA5;
-	else
-		hwif->ultra_mask = ATA_UDMA6;
-
 	hwif->dma_setup = &ali15x3_dma_setup;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
@@ -794,15 +772,34 @@ static int __devinit alim15x3_init_one(s
 		{ },
 	};
 
-	ide_pci_device_t *d = &ali15x3_chipset;
+	ide_pci_device_t d = ali15x3_chipset;
+	u8 rev = dev->revision;
 
 	if (pci_dev_present(ati_rs100))
 		printk(KERN_WARNING "alim15x3: ATI Radeon IGP Northbridge is not yet fully tested.\n");
 
+	/* don't use LBA48 DMA on ALi devices before rev 0xC5 */
+	if (rev <= 0xC4)
+		d.host_flags |= IDE_HFLAG_NO_LBA48_DMA;
+
+	if (rev >= 0x20) {
+		if (rev == 0x20)
+			d.host_flags |= IDE_HFLAG_NO_ATAPI_DMA;
+
+		if (rev < 0xC2)
+			d.udma_mask = ATA_UDMA2;
+		else if (rev == 0xC2 || rev == 0xC3)
+			d.udma_mask = ATA_UDMA4;
+		else if (rev == 0xC4)
+			d.udma_mask = ATA_UDMA5;
+		else
+			d.udma_mask = ATA_UDMA6;
+	}
+
 #if defined(CONFIG_SPARC64)
-	d->init_hwif = init_hwif_common_ali15x3;
+	d.init_hwif = init_hwif_common_ali15x3;
 #endif /* CONFIG_SPARC64 */
-	return ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, &d);
 }
 
 
