From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] trm290: remove bogus init_hwif_trm290() comment
Date: Thu, 22 Nov 2007 22:58:04 +0100
Message-ID: <200711222258.04228.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:57109 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbXKVWHR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 17:07:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409664ugc
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 14:07:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/trm290.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -240,9 +240,6 @@ static int trm290_ide_dma_test_irq (ide_
 	return (status == 0x00ff);
 }
 
-/*
- * Invoked from ide-dma.c at boot time.
- */
 static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
 	unsigned int cfgbase = 0;
