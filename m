From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/15] cs5530: remove needless ide_lock taking
Date: Mon, 1 Oct 2007 23:37:16 +0200
Message-ID: <200710012337.16971.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:61479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200AbXJAVjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:46 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977012ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5530.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.76	Aug 3 2007
+ * linux/drivers/ide/pci/cs5530.c		Version 0.77	Sep 24 2007
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
@@ -146,7 +146,6 @@ static void cs5530_set_dma_mode(ide_driv
 static unsigned int __devinit init_chipset_cs5530 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL;
-	unsigned long flags;
 
 	if (pci_resource_start(dev, 4) == 0)
 		return -EFAULT;
@@ -171,9 +170,6 @@ static unsigned int __devinit init_chips
 		goto out;
 	}
 
-	spin_lock_irqsave(&ide_lock, flags);
-		/* all CPUs (there should only be one CPU with this chipset) */
-
 	/*
 	 * Enable BusMaster and MemoryWriteAndInvalidate for the cs5530:
 	 * -->  OR 0x14 into 16-bit PCI COMMAND reg of function 0 of the cs5530
@@ -224,8 +220,6 @@ static unsigned int __devinit init_chips
 	pci_write_config_byte(master_0, 0x42, 0x00);
 	pci_write_config_byte(master_0, 0x43, 0xc1);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
-
 out:
 	pci_dev_put(master_0);
 	pci_dev_put(cs5530_0);
