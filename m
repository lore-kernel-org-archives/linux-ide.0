From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] it821x: fix incorrect SWDMA mask
Date: Tue, 3 Jul 2007 01:45:59 +0200
Message-ID: <200707030145.59287.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:18699 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbXGBX3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 19:29:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1358827ugf
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 16:29:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


SWDMA modes are unsupported by it821x.  Attempts to tune SWDMA modes always
fail (due to sanity check in ->speedproc) and result in PIO being tuned.

* Fix incorrect SWDMA mask so core code won't try these modes and will just
  tune PIO if no other DMA modes are available.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
for 2.6.22-final

 drivers/ide/pci/it821x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -1,6 +1,6 @@
 
 /*
- * linux/drivers/ide/pci/it821x.c		Version 0.15	Jun 2 2007
+ * linux/drivers/ide/pci/it821x.c		Version 0.16	Jul 3 2007
  *
  * Copyright (C) 2004		Red Hat <alan@redhat.com>
  * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
@@ -660,7 +660,6 @@ static void __devinit init_hwif_it821x(i
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 
 	hwif->ide_dma_check = &it821x_config_drive_for_dma;
 	if (!(hwif->udma_four))
