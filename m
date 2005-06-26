From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 5/13] ide hotplug mark __devinit cy82c693.c
Date: Sun, 26 Jun 2005 18:46:40 +0200
Message-ID: <20050626164640.GL12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:59319 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261459AbVFZRFD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:05:03 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
  
  
mark the __init section __devinit.
Splitted up from the Debian kernel patch. 

Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
--- a/drivers/ide/pci/cy82c693.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/cy82c693.c	2005-06-15 22:01:23.000000000 -0400
@@ -391,7 +391,7 @@
 /*
  * this function is called during init and is used to setup the cy82c693 chip
  */
-static unsigned int __init init_chipset_cy82c693(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_cy82c693(struct pci_dev *dev, const char *name)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
 		return 0;
@@ -443,7 +443,7 @@
 /*
  * the init function - called for each ide channel once
  */
-static void __init init_hwif_cy82c693(ide_hwif_t *hwif)
+static void __devinit init_hwif_cy82c693(ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
@@ -467,9 +467,9 @@
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static __initdata ide_hwif_t *primary;
+static __devinitdata ide_hwif_t *primary;
 
-void __init init_iops_cy82c693(ide_hwif_t *hwif)
+void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
 {
 	if (PCI_FUNC(hwif->pci_dev->devfn) == 1)
 		primary = hwif;
