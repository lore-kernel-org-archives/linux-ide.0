From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 11/13] ide hotplug mark __devinit slc90e66.c
Date: Sun, 26 Jun 2005 18:47:29 +0200
Message-ID: <20050626164729.GR12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:51383 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261443AbVFZREx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:04:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch. 

Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
--- a/drivers/ide/pci/slc90e66.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/slc90e66.c	2005-06-15 22:01:23.000000000 -0400
@@ -196,7 +196,7 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-static void __init init_hwif_slc90e66 (ide_hwif_t *hwif)
+static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
 {
 	u8 reg47 = 0;
 	u8 mask = hwif->channel ? 0x01 : 0x02;  /* bit0:Primary */
