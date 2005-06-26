From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 2/13] ide hotplug mark __devinit amd74xx.c
Date: Sun, 26 Jun 2005 18:46:02 +0200
Message-ID: <20050626164602.GA4698@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:57527 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261455AbVFZRFA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:05:00 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch. 

Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/amd74xx.c	2005-06-15 22:01:23.000000000 -0400
@@ -309,7 +309,7 @@
  * and initialize its drive independent registers.
  */
 
-static unsigned int __init init_chipset_amd74xx(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_amd74xx(struct pci_dev *dev, const char *name)
 {
 	unsigned char t;
 	unsigned int u;
@@ -413,7 +413,7 @@
 	return dev->irq;
 }
 
-static void __init init_hwif_amd74xx(ide_hwif_t *hwif)
+static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
 {
 	int i;
 
