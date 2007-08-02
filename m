From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5530: always tune PIO
Date: Fri, 3 Aug 2007 00:46:27 +0200
Message-ID: <200708030046.27538.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:16177 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbXHBWsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 18:48:46 -0400
Received: by nf-out-0910.google.com with SMTP id g13so172603nfb
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 15:48:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5530.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.74	Jul 28 2007
+ * linux/drivers/ide/pci/cs5530.c		Version 0.75	Aug 2 2007
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
@@ -270,20 +270,13 @@ static void __devinit init_hwif_cs5530 (
 
 	basereg = CS5530_BASEREG(hwif);
 	d0_timings = inl(basereg + 0);
-	if (CS5530_BAD_PIO(d0_timings)) {
-		/* PIO timings not initialized? */
+	if (CS5530_BAD_PIO(d0_timings))
 		outl(cs5530_pio_timings[(d0_timings >> 31) & 1][0], basereg + 0);
-		if (!hwif->drives[0].autotune)
-			hwif->drives[0].autotune = 1;
-			/* needs autotuning later */
-	}
-	if (CS5530_BAD_PIO(inl(basereg + 8))) {
-		/* PIO timings not initialized? */
+	if (CS5530_BAD_PIO(inl(basereg + 8)))
 		outl(cs5530_pio_timings[(d0_timings >> 31) & 1][0], basereg + 8);
-		if (!hwif->drives[1].autotune)
-			hwif->drives[1].autotune = 1;
-			/* needs autotuning later */
-	}
+
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
 
 	if (hwif->dma_base == 0)
 		return;
