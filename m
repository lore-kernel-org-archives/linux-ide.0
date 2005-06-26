From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 12/13] ide hotplug mark __devinit triflex.c
Date: Sun, 26 Jun 2005 18:47:36 +0200
Message-ID: <20050626164736.GS12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:50359 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261442AbVFZREx
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

diff -aurN a/drivers/ide/pci/triflex.c b/drivers/ide/pci/triflex.c
--- a/drivers/ide/pci/triflex.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/triflex.c	2005-06-15 22:01:23.000000000 -0400
@@ -130,7 +130,7 @@
 	return hwif->ide_dma_off_quietly(drive);
 }
 
-static void __init init_hwif_triflex(ide_hwif_t *hwif)
+static void __devinit init_hwif_triflex(ide_hwif_t *hwif)
 {
 	hwif->tuneproc = &triflex_tune_drive;
 	hwif->speedproc = &triflex_tune_chipset;
