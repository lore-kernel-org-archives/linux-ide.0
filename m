From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 7/13] ide hotplug mark __devinit ns87415.c
Date: Sun, 26 Jun 2005 18:46:56 +0200
Message-ID: <20050626164656.GN12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:54455 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261450AbVFZRE6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:04:58 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch. 


Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/ns87415.c b/drivers/ide/pci/ns87415.c
--- a/drivers/ide/pci/ns87415.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/ns87415.c	2005-06-15 22:01:23.000000000 -0400
@@ -195,7 +195,7 @@
 	return __ide_dma_check(drive);
 }
 
-static void __init init_hwif_ns87415 (ide_hwif_t *hwif)
+static void __devinit init_hwif_ns87415 (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	unsigned int ctrl, using_inta;
