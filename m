From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/22] ide: fix ide_unregister() usage in host drivers
Date: Thu, 17 Jan 2008 00:26:36 +0100
Message-ID: <20080116232636.9166.28571.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:10411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbYAPXOB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:14:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275985ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:14:01 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

bast-ide.c/ide-cs.c/delkin_cb.c:

* Don't set 'restore' flag for ide_unregister() when initializing new
  interface.

rapide.c/ide-pnp.c/ide-cs.c/ide_platform.c/au1xxx-ide.c/delkin_cb.c/scc_pata.c:

* Don't set 'init_default' and 'restore' flags for ide_unregister() when
  removing interface.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/bast-ide.c        |    2 +-
 drivers/ide/arm/rapide.c          |    2 +-
 drivers/ide/ide-pnp.c             |    2 +-
 drivers/ide/legacy/ide-cs.c       |    4 ++--
 drivers/ide/legacy/ide_platform.c |    2 +-
 drivers/ide/mips/au1xxx-ide.c     |    2 +-
 drivers/ide/pci/delkin_cb.c       |    4 ++--
 drivers/ide/pci/scc_pata.c        |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

Index: b/drivers/ide/arm/bast-ide.c
===================================================================
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -53,7 +53,7 @@ bastide_register(unsigned int base, unsi
 	i = hwif->index;
 
 	if (hwif->present)
-		ide_unregister(i, 0, 1);
+		ide_unregister(i, 0, 0);
 	else if (!hwif->hold)
 		ide_init_port_data(hwif, i);
 
Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -76,7 +76,7 @@ static void __devexit rapide_remove(stru
 
 	ecard_set_drvdata(ec, NULL);
 
-	ide_unregister(hwif->index, 1, 1);
+	ide_unregister(hwif->index, 0, 0);
 
 	ecard_release_resources(ec);
 }
Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -62,7 +62,7 @@ static void idepnp_remove(struct pnp_dev
 	ide_hwif_t *hwif = pnp_get_drvdata(dev);
 
 	if (hwif)
-		ide_unregister(hwif->index, 1, 1);
+		ide_unregister(hwif->index, 0, 0);
 	else
 		printk(KERN_ERR "idepnp: Unable to remove device, please report.\n");
 }
Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -163,7 +163,7 @@ static int idecs_register(unsigned long 
     i = hwif->index;
 
     if (hwif->present)
-	ide_unregister(i, 0, 1);
+	ide_unregister(i, 0, 0);
     else if (!hwif->hold)
 	ide_init_port_data(hwif, i);
 
@@ -360,7 +360,7 @@ void ide_release(struct pcmcia_device *l
     if (info->ndev) {
 	/* FIXME: if this fails we need to queue the cleanup somehow
 	   -- need to investigate the required PCMCIA magic */
-	ide_unregister(info->hd, 1, 1);
+	ide_unregister(info->hd, 0, 0);
     }
     info->ndev = 0;
 
Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -122,7 +122,7 @@ static int __devexit plat_ide_remove(str
 {
 	ide_hwif_t *hwif = pdev->dev.driver_data;
 
-	ide_unregister(hwif->index, 1, 1);
+	ide_unregister(hwif->index, 0, 0);
 
 	return 0;
 }
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -678,7 +678,7 @@ static int au_ide_remove(struct device *
 	ide_hwif_t *hwif = dev_get_drvdata(dev);
 	_auide_hwif *ahwif = &auide_hwif;
 
-	ide_unregister(hwif->index, 1, 1);
+	ide_unregister(hwif->index, 0, 0);
 
 	iounmap((void *)ahwif->regbase);
 
Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -85,7 +85,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 	i = hwif->index;
 
 	if (hwif->present)
-		ide_unregister(i, 0, 1);
+		ide_unregister(i, 0, 0);
 	else if (!hwif->hold)
 		ide_init_port_data(hwif, i);
 
@@ -120,7 +120,7 @@ delkin_cb_remove (struct pci_dev *dev)
 	ide_hwif_t *hwif = pci_get_drvdata(dev);
 
 	if (hwif)
-		ide_unregister(hwif->index, 1, 1);
+		ide_unregister(hwif->index, 0, 0);
 
 	pci_disable_device(dev);
 }
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -736,7 +736,7 @@ static void __devexit scc_remove(struct 
 		hwif->dmatable_cpu = NULL;
 	}
 
-	ide_unregister(hwif->index, 1, 1);
+	ide_unregister(hwif->index, 0, 0);
 
 	hwif->chipset = ide_unknown;
 	iounmap((void*)ports->dma);
