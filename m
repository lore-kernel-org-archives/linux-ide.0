From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/13] cs5520: always tune PIO
Date: Wed, 5 Sep 2007 23:55:04 +0200
Message-ID: <200709052355.04954.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbXIEV64 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:56 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828126nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Since cs5520 uses VDMA best PIO mode was tuned anyway by ide_dma_check()
but only if DMA was successfully initialized.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5520.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -123,10 +123,11 @@ static void __devinit init_hwif_cs5520(i
 	hwif->set_pio_mode = &cs5520_set_pio_mode;
 	hwif->set_dma_mode = &cs5520_set_dma_mode;
 
-	if (hwif->dma_base == 0) {
-		hwif->drives[1].autotune = hwif->drives[0].autotune = 1;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	if (hwif->dma_base == 0)
 		return;
-	}
 
 	hwif->ide_dma_on = &cs5520_dma_on;
 }
