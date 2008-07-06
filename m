From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/50] via82cxxx: cleanup ->init_chipset method
Date: Sun, 06 Jul 2008 19:20:27 +0200
Message-ID: <48710241.1ade660a.3458.6290@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:6801 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389AbYGFRe7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:59 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554720mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:58 -0700 (PDT)
Content-Disposition: inline; filename=via82cxxx-cleanup-init_chipset-method.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Move the boot message and via_clock setup from
  init_chipset_via82cxxx() to via_init_one().

* Set vdev->via_config in via_init_one() and cleanup
  init_chipset_via82cxxx() accordingly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/via82cxxx.c |   81 +++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -270,22 +270,11 @@ static unsigned int __devinit init_chips
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct via82cxxx_dev *vdev = host->host_priv;
-	struct pci_dev *isa = NULL;
-	struct via_isa_bridge *via_config;
+	struct via_isa_bridge *via_config = vdev->via_config;
 	u8 t, v;
 	u32 u;
 
 	/*
-	 * Find the ISA bridge to see how good the IDE is.
-	 */
-	vdev->via_config = via_config = via_config_find(&isa);
-
-	/* We checked this earlier so if it fails here deeep badness
-	   is involved */
-
-	BUG_ON(!via_config->id);
-
-	/*
 	 * Detect cable and configure Clk66
 	 */
 	pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
@@ -330,39 +319,6 @@ static unsigned int __devinit init_chips
 
 	pci_write_config_byte(dev, VIA_FIFO_CONFIG, t);
 
-	/*
-	 * Determine system bus clock.
-	 */
-
-	via_clock = (ide_pci_clk ? ide_pci_clk : 33) * 1000;
-
-	switch (via_clock) {
-		case 33000: via_clock = 33333; break;
-		case 37000: via_clock = 37500; break;
-		case 41000: via_clock = 41666; break;
-	}
-
-	if (via_clock < 20000 || via_clock > 50000) {
-		printk(KERN_WARNING "VP_IDE: User given PCI clock speed "
-			"impossible (%d), using 33 MHz instead.\n", via_clock);
-		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want "
-			"to assume 80-wire cable.\n");
-		via_clock = 33333;
-	}
-
-	/*
-	 * Print the boot message.
-	 */
-
-	printk(KERN_INFO "VP_IDE: VIA %s (rev %02x) IDE %sDMA%s "
-		"controller on pci%s\n",
-		via_config->name, isa->revision,
-		via_config->udma_mask ? "U" : "MW",
-		via_dma[via_config->udma_mask ?
-			(fls(via_config->udma_mask) - 1) : 0],
-		pci_name(dev));
-
-	pci_dev_put(isa);
 	return 0;
 }
 
@@ -444,12 +400,43 @@ static int __devinit via_init_one(struct
 	 * Find the ISA bridge and check we know what it is.
 	 */
 	via_config = via_config_find(&isa);
-	pci_dev_put(isa);
 	if (!via_config->id) {
 		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, disabling DMA.\n");
 		return -ENODEV;
 	}
 
+	/*
+	 * Print the boot message.
+	 */
+	printk(KERN_INFO "VP_IDE: VIA %s (rev %02x) IDE %sDMA%s "
+		"controller on pci%s\n",
+		via_config->name, isa->revision,
+		via_config->udma_mask ? "U" : "MW",
+		via_dma[via_config->udma_mask ?
+			(fls(via_config->udma_mask) - 1) : 0],
+		pci_name(dev));
+
+	pci_dev_put(isa);
+
+	/*
+	 * Determine system bus clock.
+	 */
+	via_clock = (ide_pci_clk ? ide_pci_clk : 33) * 1000;
+
+	switch (via_clock) {
+	case 33000: via_clock = 33333; break;
+	case 37000: via_clock = 37500; break;
+	case 41000: via_clock = 41666; break;
+	}
+
+	if (via_clock < 20000 || via_clock > 50000) {
+		printk(KERN_WARNING "VP_IDE: User given PCI clock speed "
+			"impossible (%d), using 33 MHz instead.\n", via_clock);
+		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want "
+			"to assume 80-wire cable.\n");
+		via_clock = 33333;
+	}
+
 	if (idx == 0)
 		d.host_flags |= IDE_HFLAG_NO_AUTODMA;
 	else
@@ -471,6 +458,8 @@ static int __devinit via_init_one(struct
 		return -ENOMEM;
 	}
 
+	vdev->via_config = via_config;
+
 	rc = ide_pci_init_one(dev, &d, vdev);
 	if (rc)
 		kfree(vdev);

-- 

