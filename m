From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] siimage: remove resetproc() method
Date: Fri, 16 Nov 2007 17:16:16 +0300
Message-ID: <200711161716.16288.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:5917 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932741AbXKPOQD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 09:16:03 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

The intent behind siimage_reset() was probably to hard reset the interface and
the SATA PHY but as the code writes to two reserved bits instead, it obviously
has been ineffective from the start. So, just remove it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This was discussed on linux-ide 4 months ago already, and the libata driver
still has the same bogus code. :-|
This patch is against Linus' tree...

 drivers/ide/pci/siimage.c |   45 +--------------------------------------------
 1 files changed, 1 insertion(+), 44 deletions(-)

Index: linux-2.6/drivers/ide/pci/siimage.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/siimage.c
+++ linux-2.6/drivers/ide/pci/siimage.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.18	Oct 18 2007
+ * linux/drivers/ide/pci/siimage.c		Version 1.19	Nov 16 2007
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
@@ -460,48 +460,6 @@ static void sil_sata_pre_reset(ide_drive
 }
 
 /**
- *	siimage_reset	-	reset a device on an siimage controller
- *	@drive: drive to reset
- *
- *	Perform a controller level reset fo the device. For
- *	SATA we must also check the PHY.
- */
- 
-static void siimage_reset (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 reset		= 0;
-	unsigned long addr	= siimage_selreg(hwif, 0);
-
-	if (hwif->mmio) {
-		reset = hwif->INB(addr);
-		hwif->OUTB((reset|0x03), addr);
-		/* FIXME:posting */
-		udelay(25);
-		hwif->OUTB(reset, addr);
-		(void) hwif->INB(addr);
-	} else {
-		pci_read_config_byte(hwif->pci_dev, addr, &reset);
-		pci_write_config_byte(hwif->pci_dev, addr, reset|0x03);
-		udelay(25);
-		pci_write_config_byte(hwif->pci_dev, addr, reset);
-		pci_read_config_byte(hwif->pci_dev, addr, &reset);
-	}
-
-	if (SATA_STATUS_REG) {
-		/* SATA_STATUS_REG is valid only when in MMIO mode */
-		u32 sata_stat = readl((void __iomem *)SATA_STATUS_REG);
-		printk(KERN_WARNING "%s: reset phy, status=0x%08x, %s\n",
-			hwif->name, sata_stat, __FUNCTION__);
-		if (!(sata_stat)) {
-			printk(KERN_WARNING "%s: reset phy dead, status=0x%08x\n",
-				hwif->name, sata_stat);
-			drive->failures++;
-		}
-	}
-}
-
-/**
  *	proc_reports_siimage		-	add siimage controller to proc
  *	@dev: PCI device
  *	@clocking: SCSC value
@@ -857,7 +815,6 @@ static void __devinit init_hwif_siimage(
 {
 	u8 sata = is_sata(hwif);
 
-	hwif->resetproc = &siimage_reset;
 	hwif->set_pio_mode = &sil_set_pio_mode;
 	hwif->set_dma_mode = &sil_set_dma_mode;
 

