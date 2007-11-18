From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/21] sgiioc4: always init hwif->io_ports
Date: Sun, 18 Nov 2007 23:26:26 +0100
Message-ID: <200711182326.26860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48819 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbXKRWgq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873018ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeremy Higdon <jeremy@sgi.com>


'if (hwif->io_ports[IDE_DATA_OFFSET] != cmd_base)' is always true.

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -593,6 +593,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	ide_hwif_t *hwif;
 	int h;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw;
 
 	/*
 	 * Find an empty HWIF; if none available, return -ENOMEM.
@@ -632,15 +633,11 @@ sgiioc4_ide_setup_pci_device(struct pci_
 		return -ENOMEM;
 	}
 
-	if (hwif->io_ports[IDE_DATA_OFFSET] != cmd_base) {
-		hw_regs_t hw;
-
-		/* Initialize the IO registers */
-		memset(&hw, 0, sizeof(hw));
-		sgiioc4_init_hwif_ports(&hw, cmd_base, ctl, irqport);
-		memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-	}
+	/* Initialize the IO registers */
+	memset(&hw, 0, sizeof(hw));
+	sgiioc4_init_hwif_ports(&hw, cmd_base, ctl, irqport);
+	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
+	hwif->noprobe = 0;
 
 	hwif->irq = dev->irq;
 	hwif->chipset = ide_pci;
