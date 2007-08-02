From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] slc90e66: always tune PIO
Date: Fri, 3 Aug 2007 00:45:10 +0200
Message-ID: <200708030045.10051.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:37975 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbXHBWso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 18:48:44 -0400
Received: by mu-out-0910.google.com with SMTP id i10so801784mue
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 15:48:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/slc90e66.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.16	Jul 14, 2007
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.17	Aug 2, 2007
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
@@ -169,11 +169,11 @@ static void __devinit init_hwif_slc90e66
 
 	pci_read_config_byte(hwif->pci_dev, 0x47, &reg47);
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	if (hwif->dma_base == 0)
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x1f;
