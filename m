From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] ide: use ide_init_port_hw() in setup-pci.c
Date: Tue, 27 Nov 2007 23:58:28 +0100
Message-ID: <200711272358.28134.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:45106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbXK0WxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 17:53:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1367714ugc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 14:53:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Move setting hwif->gendev.parent from ide_pci_setup_ports()
  to ide_hwif_configure().

* Always set hwif->io_ports in ide_hwif_configure().

* Use ide_init_port_hw() in ide_hwif_configure().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -363,6 +363,8 @@ static ide_hwif_t *ide_hwif_configure(st
 	unsigned long ctl = 0, base = 0;
 	ide_hwif_t *hwif;
 	u8 bootable = (d->host_flags & IDE_HFLAG_BOOTABLE) ? 1 : 0;
+	u8 oldnoprobe = 0;
+	struct hw_regs_s hw;
 
 	if ((d->host_flags & IDE_HFLAG_ISA_PORTS) == 0) {
 		/*  Possibly we should fail if these checks report true */
@@ -385,22 +387,25 @@ static ide_hwif_t *ide_hwif_configure(st
 	}
 	if ((hwif = ide_match_hwif(base, bootable, d->name)) == NULL)
 		return NULL;	/* no room in ide_hwifs[] */
-	if (hwif->io_ports[IDE_DATA_OFFSET] != base ||
-	    hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
-		hw_regs_t hw;
-
-		memset(&hw, 0, sizeof(hw));
-		ide_std_init_ports(&hw, base, ctl | 2);
-		memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-		hwif->noprobe = 0;
-	}
-	hwif->chipset = d->chipset ? d->chipset : ide_pci;
+
+	memset(&hw, 0, sizeof(hw));
+	hw.irq = hwif->irq ? hwif->irq : irq;
+	hw.dev = &dev->dev;
+	hw.chipset = d->chipset ? d->chipset : ide_pci;
+	ide_std_init_ports(&hw, base, ctl | 2);
+
+	if (hwif->io_ports[IDE_DATA_OFFSET] == base &&
+	    hwif->io_ports[IDE_CONTROL_OFFSET] == (ctl | 2))
+		oldnoprobe = hwif->noprobe;
+
+	ide_init_port_hw(hwif, &hw);
+
+	hwif->noprobe = oldnoprobe;
+
 	hwif->pci_dev = dev;
 	hwif->cds = d;
 	hwif->channel = port;
 
-	if (!hwif->irq)
-		hwif->irq = irq;
 	if (mate) {
 		hwif->mate = mate;
 		mate->mate = hwif;
@@ -535,12 +540,8 @@ void ide_pci_setup_ports(struct pci_dev 
 		if ((hwif = ide_hwif_configure(dev, d, mate, port, pciirq)) == NULL)
 			continue;
 
-		/* setup proper ancestral information */
-		hwif->gendev.parent = &dev->dev;
-
 		*(idx + port) = hwif->index;
 
-		
 		if (d->init_iops)
 			d->init_iops(hwif);
 
