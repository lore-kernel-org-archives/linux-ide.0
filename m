From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 10/13] ide hotplug mark __devinit sl82c105.c
Date: Sun, 26 Jun 2005 18:47:23 +0200
Message-ID: <20050626164723.GQ12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:52407 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261444AbVFZREz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:04:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch. 


Signed-off-by: maximilian attems <janitor@sternwelten.at>


diff -aurN a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
--- a/drivers/ide/pci/sl82c105.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/sl82c105.c	2005-06-15 22:01:23.000000000 -0400
@@ -386,7 +386,7 @@
  * channel 0 here at least, but channel 1 has to be enabled by
  * firmware or arch code. We still set both to 16 bits mode.
  */
-static unsigned int __init init_chipset_sl82c105(struct pci_dev *dev, const char *msg)
+static unsigned int __devinit init_chipset_sl82c105(struct pci_dev *dev, const char *msg)
 {
 	u32 val;
 
@@ -399,7 +399,7 @@
 	return dev->irq;
 }
 
-static void __init init_dma_sl82c105(ide_hwif_t *hwif, unsigned long dma_base)
+static void __devinit init_dma_sl82c105(ide_hwif_t *hwif, unsigned long dma_base)
 {
 	unsigned int rev;
 	u8 dma_state;
@@ -431,7 +431,7 @@
  * Initialise the chip
  */
 
-static void __init init_hwif_sl82c105(ide_hwif_t *hwif)
+static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	u32 val;
