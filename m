From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 13/13] ide hotplug mark __devinit via82cxxx.c
Date: Sun, 26 Jun 2005 18:47:56 +0200
Message-ID: <20050626164756.GT12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:48823 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261441AbVFZREw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:04:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch. 


Signed-off-by: maximilian attems <janitor@sternwelten.at>
 
diff -aurN a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/via82cxxx.c	2005-06-15 22:01:23.000000000 -0400
@@ -415,7 +415,7 @@
  *	and initialize its drive independent registers.
  */
 
-static unsigned int __init init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *isa = NULL;
 	u8 t, v;
@@ -576,7 +576,7 @@
 	return 0;
 }
 
-static void __init init_hwif_via82cxxx(ide_hwif_t *hwif)
+static void __devinit init_hwif_via82cxxx(ide_hwif_t *hwif)
 {
 	int i;
 
