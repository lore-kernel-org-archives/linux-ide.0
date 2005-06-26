From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 4/13] ide hotplug mark __devinit cs5530.c
Date: Sun, 26 Jun 2005 18:46:27 +0200
Message-ID: <20050626164627.GK12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:55479 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261451AbVFZRE6
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
 
diff -aurN a/drivers/ide/pci/cs5530.c b/drivers/ide/pci/cs5530.c
--- a/drivers/ide/pci/cs5530.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/cs5530.c	2005-06-15 22:01:23.000000000 -0400
@@ -217,7 +217,7 @@
  *	Initialize the cs5530 bridge for reliable IDE DMA operation.
  */
 
-static unsigned int __init init_chipset_cs5530 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_cs5530 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
 	unsigned long flags;
@@ -308,7 +308,7 @@
  *	performs channel-specific pre-initialization before drive probing.
  */
 
-static void __init init_hwif_cs5530 (ide_hwif_t *hwif)
+static void __devinit init_hwif_cs5530 (ide_hwif_t *hwif)
 {
 	unsigned long basereg;
 	u32 d0_timings;
