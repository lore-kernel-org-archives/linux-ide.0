From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/50] ide: respect dev->irq in do_ide_setup_pci_device() also if tried_config
Date: Sun, 06 Jul 2008 19:20:13 +0200
Message-ID: <4871022f.1ade660a.3458.626a@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:6801 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbYGFRem (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:42 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554720mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:40 -0700 (PDT)
Content-Disposition: inline; filename=ide-respect-dev-irq-in-do_ide_setup_pci_device-also-if-tried_config.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* If device is in the PCI native mode respect dev->irq regardless of
  'tried_config' in do_ide_setup_pci_device().

* Drop no longer needed 'config' argument from ide_setup_pci_controller().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -392,14 +392,14 @@ int ide_hwif_setup_dma(ide_hwif_t *hwif,
  *	@dev: PCI device
  *	@d: IDE port info
  *	@noisy: verbose flag
- *	@config: returned as 1 if we configured the hardware
  *
  *	Set up the PCI and controller side of the IDE interface. This brings
  *	up the PCI side of the device, checks that the device is enabled
  *	and enables it if need be
  */
 
-static int ide_setup_pci_controller(struct pci_dev *dev, const struct ide_port_info *d, int noisy, int *config)
+static int ide_setup_pci_controller(struct pci_dev *dev,
+				    const struct ide_port_info *d, int noisy)
 {
 	int ret;
 	u16 pcicmd;
@@ -420,7 +420,6 @@ static int ide_setup_pci_controller(stru
 		ret = ide_pci_configure(dev, d);
 		if (ret < 0)
 			goto out;
-		*config = 1;
 		printk(KERN_INFO "%s: device enabled (Linux)\n", d->name);
 	}
 
@@ -486,10 +485,9 @@ static int do_ide_setup_pci_device(struc
 				   const struct ide_port_info *d,
 				   u8 noisy)
 {
-	int tried_config = 0;
 	int pciirq, ret;
 
-	ret = ide_setup_pci_controller(dev, d, noisy, &tried_config);
+	ret = ide_setup_pci_controller(dev, d, noisy);
 	if (ret < 0)
 		goto out;
 
@@ -514,10 +512,6 @@ static int do_ide_setup_pci_device(struc
 			printk(KERN_INFO "%s: not 100%% native mode: "
 				"will probe irqs later\n", d->name);
 		pciirq = ret;
-	} else if (tried_config) {
-		if (noisy)
-			printk(KERN_INFO "%s: will probe irqs later\n", d->name);
-		pciirq = 0;
 	} else if (!pciirq) {
 		if (noisy)
 			printk(KERN_WARNING "%s: bad irq (%d): will probe later\n",

-- 

