From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/50] ide: always call ->init_chipset method in do_ide_setup_pci_device()
Date: Sun, 06 Jul 2008 19:20:12 +0200
Message-ID: <4871022e.1ade660a.3458.6266@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbYGFRek (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:40 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985609ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:39 -0700 (PDT)
Content-Disposition: inline; filename=ide-always-call-init_chipset-method-in-do_ide_setup_pci_device.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Call ->init_chipset method also for 'tried_config' / '!pciirq' conditions.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -498,20 +498,21 @@ static int do_ide_setup_pci_device(struc
 	 */
 	pciirq = dev->irq;
 
+	/*
+	 * This allows offboard ide-pci cards the enable a BIOS,
+	 * verify interrupt settings of split-mirror pci-config
+	 * space, place chipset into init-mode, and/or preserve
+	 * an interrupt if the card is not native ide support.
+	 */
+	ret = d->init_chipset ? d->init_chipset(dev, d->name) : 0;
+	if (ret < 0)
+		goto out;
+
 	/* Is it an "IDE storage" device in non-PCI mode? */
 	if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 5) != 5) {
 		if (noisy)
 			printk(KERN_INFO "%s: not 100%% native mode: "
 				"will probe irqs later\n", d->name);
-		/*
-		 * This allows offboard ide-pci cards the enable a BIOS,
-		 * verify interrupt settings of split-mirror pci-config
-		 * space, place chipset into init-mode, and/or preserve
-		 * an interrupt if the card is not native ide support.
-		 */
-		ret = d->init_chipset ? d->init_chipset(dev, d->name) : 0;
-		if (ret < 0)
-			goto out;
 		pciirq = ret;
 	} else if (tried_config) {
 		if (noisy)
@@ -523,11 +524,6 @@ static int do_ide_setup_pci_device(struc
 				d->name, pciirq);
 		pciirq = 0;
 	} else {
-		if (d->init_chipset) {
-			ret = d->init_chipset(dev, d->name);
-			if (ret < 0)
-				goto out;
-		}
 		if (noisy)
 			printk(KERN_INFO "%s: 100%% native mode on irq %d\n",
 				d->name, pciirq);

-- 

