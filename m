From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/15] ide: enhance ide_setup_pci_noise()
Date: Mon, 1 Oct 2007 23:37:55 +0200
Message-ID: <200710012337.55764.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:62096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbXJAVjr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:47 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977013ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Print PCI device Vendor ID, Device ID and revision in
  ide_setup_pci_noise().

* Remove no longer needed PCI device revision printing from
  ide_setup_pci_controller().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -227,8 +227,9 @@ static unsigned long ide_get_or_set_dma_
 
 void ide_setup_pci_noise(struct pci_dev *dev, const struct ide_port_info *d)
 {
-	printk(KERN_INFO "%s: IDE controller at PCI slot %s\n",
-			 d->name, pci_name(dev));
+	printk(KERN_INFO "%s: IDE controller (0x%04x:0x%04x rev 0x%02x) at "
+			 " PCI slot %s\n", d->name, dev->vendor, dev->device,
+			 dev->revision, pci_name(dev));
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_noise);
@@ -497,9 +498,6 @@ static int ide_setup_pci_controller(stru
 		printk(KERN_INFO "%s: device enabled (Linux)\n", d->name);
 	}
 
-	if (noisy)
-		printk(KERN_INFO "%s: chipset revision %d\n",
-				 d->name, dev->revision);
 out:
 	return ret;
 }
