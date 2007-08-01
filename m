From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] sis5513: always tune PIO
Date: Wed, 1 Aug 2007 22:39:18 +0200
Message-ID: <200708012239.18820.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:40293 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbXHAUlW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 16:41:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so82892nfb
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 13:41:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Always set ->autotune in init_hwif_sis5513(), this means practically
  no change in behavior since PIO was always tuned in ->ide_dma_check
  and >autotune was always set for ->dma_base == 0 case.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.28	Aug 1, 2007
+ * linux/drivers/ide/pci/sis5513.c	Version 0.29	Aug 1, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -603,11 +603,6 @@ static void sis_set_dma_mode(ide_drive_t
 
 static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
-	/*
-	 * TODO: always set PIO mode and remove this
-	 */
-	ide_set_max_pio(drive);
-
 	drive->init_speed = 0;
 
 	if (ide_tune_dma(drive))
@@ -841,11 +836,11 @@ static void __devinit init_hwif_sis5513 
 	if (chipset_family >= ATA_133)
 		hwif->udma_filter = sis5513_ata133_udma_filter;
 
-	if (!(hwif->dma_base)) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	if (hwif->dma_base == 0)
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 
