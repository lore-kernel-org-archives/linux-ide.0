From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 6/13] ide hotplug mark __devinit it8172.c
Date: Sun, 26 Jun 2005 18:46:48 +0200
Message-ID: <20050626164648.GM12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:60599 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261460AbVFZRFE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:05:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
  
  
mark the __init section __devinit.
Splitted up from the Debian kernel patch. 


Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/it8172.c b/drivers/ide/pci/it8172.c
--- a/drivers/ide/pci/it8172.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/it8172.c	2005-06-15 22:01:23.000000000 -0400
@@ -216,7 +216,7 @@
 	return 0;
 }
 
-static unsigned int __init init_chipset_it8172 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_it8172 (struct pci_dev *dev, const char *name)
 {
 	unsigned char progif;
     
@@ -230,7 +230,7 @@
 }
 
 
-static void __init init_hwif_it8172 (ide_hwif_t *hwif)
+static void __devinit init_hwif_it8172 (ide_hwif_t *hwif)
 {
 	struct pci_dev* dev = hwif->pci_dev;
 	unsigned long cmdBase, ctrlBase;
