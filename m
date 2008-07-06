From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/50] amd74xx: cleanup ->init_chipset method
Date: Sun, 06 Jul 2008 19:20:25 +0200
Message-ID: <4871023f.1ade660a.3458.628b@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623AbYGFRe5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:57 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985609ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:56 -0700 (PDT)
Content-Disposition: inline; filename=amd74xx-cleanup-init_chipset-method.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Move amd_clock setup from init_chipset_amd74xx() to amd74xx_probe().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/amd74xx.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -173,24 +173,6 @@ static unsigned int __devinit init_chips
 		t |= 0xf0;
 	pci_write_config_byte(dev, AMD_IDE_CONFIG + offset, t);
 
-/*
- * Determine the system bus clock.
- */
-
-	amd_clock = (ide_pci_clk ? ide_pci_clk : 33) * 1000;
-
-	switch (amd_clock) {
-		case 33000: amd_clock = 33333; break;
-		case 37000: amd_clock = 37500; break;
-		case 41000: amd_clock = 41666; break;
-	}
-
-	if (amd_clock < 20000 || amd_clock > 50000) {
-		printk(KERN_WARNING "%s: User given PCI clock speed impossible (%d), using 33 MHz instead.\n",
-				    name, amd_clock);
-		amd_clock = 33333;
-	}
-
 	return dev->irq;
 }
 
@@ -302,6 +284,24 @@ static int __devinit amd74xx_probe(struc
 			 d.name, pci_name(dev), dev->revision,
 			 amd_dma[fls(d.udma_mask) - 1]);
 
+	/*
+	* Determine the system bus clock.
+	*/
+	amd_clock = (ide_pci_clk ? ide_pci_clk : 33) * 1000;
+
+	switch (amd_clock) {
+	case 33000: amd_clock = 33333; break;
+	case 37000: amd_clock = 37500; break;
+	case 41000: amd_clock = 41666; break;
+	}
+
+	if (amd_clock < 20000 || amd_clock > 50000) {
+		printk(KERN_WARNING "%s: User given PCI clock speed impossible"
+				    " (%d), using 33 MHz instead.\n",
+				    d.name, amd_clock);
+		amd_clock = 33333;
+	}
+
 	return ide_pci_init_one(dev, &d, NULL);
 }
 

-- 

