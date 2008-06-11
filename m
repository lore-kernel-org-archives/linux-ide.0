From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/5] sgiioc4: call ide_find_port_slot() later
Date: Wed, 11 Jun 2008 21:22:45 +0200
Message-ID: <200806112122.45788.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:60653 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbYFKU0I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:26:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234785fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:26:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

Move ide_find_port_slot() call closer to ide_device_add().

This is basically a preparation for the future changes.

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -588,10 +588,6 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	hw_regs_t hw;
 	struct ide_port_info d = sgiioc4_port_info;
 
-	hwif = ide_find_port_slot(&d);
-	if (hwif == NULL)
-		return -ENOMEM;
-
 	/*  Get the CmdBlk and CtrlBlk Base Registers */
 	bar0 = pci_resource_start(dev, 0);
 	virt_base = ioremap(bar0, pci_resource_len(dev, 0));
@@ -621,6 +617,11 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	hw.irq = dev->irq;
 	hw.chipset = ide_pci;
 	hw.dev = &dev->dev;
+
+	hwif = ide_find_port_slot(&d);
+	if (hwif == NULL)
+		goto err;
+
 	ide_init_port_hw(hwif, &hw);
 
 	/* The IOC4 uses MMIO rather than Port IO. */
@@ -637,6 +638,10 @@ sgiioc4_ide_setup_pci_device(struct pci_
 		return -EIO;
 
 	return 0;
+err:
+	release_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE);
+	iounmap(virt_base);
+	return -ENOMEM;
 }
 
 static unsigned int __devinit
