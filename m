From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] delkin_cb: fix resources handling
Date: Wed, 20 Feb 2008 01:46:24 +0100
Message-ID: <200802200146.24248.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:37570 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbYBTAg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 19:36:29 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2708602fkz.5
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 16:36:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>

Tell IDE layer to not manage resources by setting hwif->mmio flag.

Cc: Mark Lord <mlord@pobox.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/delkin_cb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -71,7 +71,6 @@ delkin_cb_probe (struct pci_dev *dev, co
 		if (setup[i])
 			outb(setup[i], base + i);
 	}
-	pci_release_regions(dev);	/* IDE layer handles regions itself */
 
 	memset(&hw, 0, sizeof(hw));
 	ide_std_init_ports(&hw, base + 0x10, base + 0x1e);
@@ -90,6 +89,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 		ide_init_port_data(hwif, i);
 
 	ide_init_port_hw(hwif, &hw);
+	hwif->mmio = 1;
 	hwif->quirkproc = &ide_undecoded_slave;
 
 	idx[0] = i;
@@ -110,6 +110,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 
 out_disable:
 	printk(KERN_ERR "delkin_cb: no IDE devices found\n");
+	pci_release_regions(dev);
 	pci_disable_device(dev);
 	return -ENODEV;
 }
@@ -122,6 +123,7 @@ delkin_cb_remove (struct pci_dev *dev)
 	if (hwif)
 		ide_unregister(hwif->index);
 
+	pci_release_regions(dev);
 	pci_disable_device(dev);
 }
 
