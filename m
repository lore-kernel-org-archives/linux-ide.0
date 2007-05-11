From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6 fix queue] aec62xx: rework init_setup_aec6x80()
Date: Fri, 11 May 2007 23:31:46 +0400
Message-ID: <200705112331.46859.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:56178 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759893AbXEKTaO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 15:30:14 -0400
In-Reply-To: <200702162321.40813.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Rework init_setup_aec6x80() so that it won't rewrite the constant name strings
anymore -- in order to do this:

- in aec62xx_init_one(), pass a local copy of 'struct pci_device_id' down the
  call chain;

- change the names for in aec62xx_chipsets[] to default to AEC-6280[R];

- override the 'name' field in init_setup_aec6x80() only if bit 4 of the DMA
  status register is set.

While at it, also change the 'udma_mask' field for AEC-6x80R chips in this
function and remove the code doing the same from the init_hwif() method...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch should apply somewhere near the start of pata-2.6 patchset.
Warning: the patch has only been compile tested.

 drivers/ide/pci/aec62xx.c |   35 +++++++++++++----------------------
 1 files changed, 13 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/aec62xx.c
+++ linux-2.6/drivers/ide/pci/aec62xx.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/aec62xx.c		Version 0.21	Apr 21, 2007
+ * linux/drivers/ide/pci/aec62xx.c		Version 0.22	Apr 23, 2007
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
@@ -243,14 +243,6 @@ static void __devinit init_hwif_aec62xx(
 	}
 
 	hwif->ultra_mask = hwif->cds->udma_mask;
-
-	/* atp865 and atp865r */
-	if (hwif->ultra_mask == 0x3f) {
-		/* check bit 0x10 of DMA status register */
-		if (inb(pci_resource_start(dev, 4) + 2) & 0x10)
- 			hwif->ultra_mask = 0x7f; /* udma0-6 */
-	}
-
 	hwif->mwdma_mask = 0x07;
 
 	hwif->ide_dma_check	= &aec62xx_config_drive_xfer_rate;
@@ -291,16 +283,12 @@ static int __devinit init_setup_aec62xx(
 
 static int __devinit init_setup_aec6x80(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	unsigned long bar4reg = pci_resource_start(dev, 4);
+	unsigned long dma_base = pci_resource_start(dev, 4);
 
-	if (inb(bar4reg+2) & 0x10) {
-		strcpy(d->name, "AEC6880");
-		if (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R)
-			strcpy(d->name, "AEC6880R");
-	} else {
-		strcpy(d->name, "AEC6280");
-		if (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R)
-			strcpy(d->name, "AEC6280R");
+	if (inb(dma_base + 2) & 0x10) {
+		d->name = (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R) ?
+			  "AEC6880R" : "AEC6880";
+		d->udma_mask = 0x7f; /* udma0-6 */
 	}
 
 	return ide_setup_pci_device(dev, d);
@@ -340,7 +328,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.bootable	= NEVER_BOARD,
 		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 3 */
-		.name		= "AEC6X80",
+		.name		= "AEC6280",
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
@@ -350,7 +338,7 @@ static ide_pci_device_t aec62xx_chipsets
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	},{	/* 4 */
-		.name		= "AEC6X80R",
+		.name		= "AEC6280R",
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
@@ -370,13 +358,16 @@ static ide_pci_device_t aec62xx_chipsets
  *
  *	Called when the PCI registration layer (or the IDE initialization)
  *	finds a device matching our IDE device tables.
+ *
+ *	NOTE: since we're going to modify the 'name' field for AEC-6[26]80[R]
+ *	chips, pass a local copy of 'struct pci_device_id' down the call chain.
  */
  
 static int __devinit aec62xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &aec62xx_chipsets[id->driver_data];
+	ide_pci_device_t d = aec62xx_chipsets[id->driver_data];
 
-	return d->init_setup(dev, d);
+	return d.init_setup(dev, &d);
 }
 
 static struct pci_device_id aec62xx_pci_tbl[] = {

