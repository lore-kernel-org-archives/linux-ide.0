From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/13] alim15x3: always tune PIO
Date: Wed, 5 Sep 2007 23:59:53 +0200
Message-ID: <200709052359.53505.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:1704 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbXIEV7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:59:02 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828160nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:59:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/alim15x3.c		Version 0.26	Jul 14 2007
+ * linux/drivers/ide/pci/alim15x3.c		Version 0.27	Aug 27 2007
  *
  *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
  *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
@@ -668,11 +668,11 @@ static void __devinit init_hwif_common_a
 	if (m5229_revision <= 0xC4)
 		hwif->host_flags |= IDE_HFLAG_NO_LBA48_DMA;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	if (hwif->dma_base == 0)
 		return;
-	}
 
 	/*
 	 * check in ->init_dma guarantees m5229_revision >= 0x20 here
