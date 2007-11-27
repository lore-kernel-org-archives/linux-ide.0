From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] au1xxx-ide: au_ide_probe() fixes
Date: Tue, 27 Nov 2007 23:55:32 +0100
Message-ID: <200711272355.33053.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:44202 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbXK0WxE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 17:53:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1367703ugc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 14:53:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* hwif->hold is always set in au_ide_probe() (few lines earlier),
  no need to set it again

* hwif->{channel,select_data,config_data} should be always zero

* autotune PIO also if CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_BDMA is not defined

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -677,15 +677,14 @@ static int au_ide_probe(struct device *d
 	hwif->dma_setup                 = &auide_dma_setup;
 	hwif->ide_dma_test_irq          = &auide_dma_test_irq;
 	hwif->dma_lost_irq		= &auide_dma_lost_irq;
-#else /* !CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
+#endif
 	hwif->channel                   = 0;
-	hwif->hold                      = 1;
 	hwif->select_data               = 0;    /* no chipset-specific code */
 	hwif->config_data               = 0;    /* no chipset-specific code */
 
 	hwif->drives[0].autotune        = 1;    /* 1=autotune, 2=noautotune, 0=default */
 	hwif->drives[1].autotune	= 1;
-#endif
+
 	hwif->drives[0].no_io_32bit	= 1;
 	hwif->drives[1].no_io_32bit	= 1;
 
