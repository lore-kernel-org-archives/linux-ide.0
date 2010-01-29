From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/68] ide: split host->dev table
Date: Fri, 29 Jan 2010 17:05:05 +0100
Message-ID: <20100129160505.21495.65389.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754221Ab0A2QTA@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: split host->dev table

Split dev table in struct ide_host on dev and dev2 fields to match
corresponding fields used in struct ata_host.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cy82c693.c     |    2 +-
 drivers/ide/hpt366.c       |    6 +++---
 drivers/ide/ide-probe.c    |    2 +-
 drivers/ide/ide.c          |    4 ++--
 drivers/ide/pdc202xx_new.c |    2 +-
 drivers/ide/setup-pci.c    |    6 +++---
 include/linux/ide.h        |    2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

Index: b/drivers/ide/cy82c693.c
===================================================================
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -179,7 +179,7 @@ static int __devinit cy82c693_init_one(s
 static void __devexit cy82c693_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
-	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
+	struct pci_dev *dev2 = host->dev2 ? to_pci_dev(host->dev2) : NULL;
 
 	ide_pci_remove(dev);
 	pci_dev_put(dev2);
Index: b/drivers/ide/hpt366.c
===================================================================
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -610,7 +610,7 @@ static struct hpt_info *hpt3xx_get_info(
 	struct ide_host *host	= dev_get_drvdata(dev);
 	struct hpt_info *info	= (struct hpt_info *)host->host_priv;
 
-	return dev == host->dev[1] ? info + 1 : info;
+	return dev == host->dev2 ? info + 1 : info;
 }
 
 /*
@@ -943,7 +943,7 @@ static int hpt37x_calibrate_dpll(struct
 static void hpt3xx_disable_fast_irq(struct pci_dev *dev, u8 mcr_addr)
 {
 	struct ide_host *host	= pci_get_drvdata(dev);
-	struct hpt_info *info	= host->host_priv + (&dev->dev == host->dev[1]);
+	struct hpt_info *info	= host->host_priv + (&dev->dev == host->dev2);
 	u8  chip_type		= info->chip_type;
 	u8  new_mcr, old_mcr	= 0;
 
@@ -1567,7 +1567,7 @@ static void __devexit hpt366_remove(stru
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct ide_info *info = host->host_priv;
-	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
+	struct pci_dev *dev2 = host->dev2 ? to_pci_dev(host->dev2) : NULL;
 
 	ide_pci_remove(dev);
 	pci_dev_put(dev2);
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1334,7 +1334,7 @@ struct ide_host *ide_host_alloc(const st
 		return NULL;
 	}
 
-	host->dev[0] = dev;
+	host->dev = dev;
 
 	if (d) {
 		host->init_chipset = d->init_chipset;
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -77,7 +77,7 @@ int ide_device_get(ide_drive_t *drive)
 	if (!get_device(&drive->gendev))
 		return -ENXIO;
 
-	host_dev = drive->hwif->host->dev[0];
+	host_dev = drive->hwif->host->dev;
 	module = host_dev ? host_dev->driver->owner : NULL;
 
 	if (module && !try_module_get(module)) {
@@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(ide_device_get);
 void ide_device_put(ide_drive_t *drive)
 {
 #ifdef CONFIG_MODULE_UNLOAD
-	struct device *host_dev = drive->hwif->host->dev[0];
+	struct device *host_dev = drive->hwif->host->dev;
 	struct module *module = host_dev ? host_dev->driver->owner : NULL;
 
 	if (module)
Index: b/drivers/ide/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -517,7 +517,7 @@ static int __devinit pdc202new_init_one(
 static void __devexit pdc202new_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
-	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
+	struct pci_dev *dev2 = host->dev2 ? to_pci_dev(host->dev2) : NULL;
 
 	ide_pci_remove(dev);
 	pci_dev_put(dev2);
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -556,9 +556,9 @@ int ide_pci_init_two(struct pci_dev *dev
 		goto out;
 	}
 
-	host->dev[0] = &dev1->dev;
+	host->dev = &dev1->dev;
 	if (dev2)
-		host->dev[1] = &dev2->dev;
+		host->dev2 = &dev2->dev;
 
 	host->host_priv = priv;
 	host->irq_flags = IRQF_SHARED;
@@ -603,7 +603,7 @@ EXPORT_SYMBOL_GPL(ide_pci_init_one);
 void ide_pci_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
-	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
+	struct pci_dev *dev2 = host->dev2 ? to_pci_dev(host->dev2) : NULL;
 	int bars;
 
 	if (host->host_flags & IDE_HFLAG_SINGLE)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -775,7 +775,7 @@ typedef struct hwif_s {
 struct ide_host {
 	ide_hwif_t	*ports[MAX_HOST_PORTS + 1];
 	unsigned int	n_ports;
-	struct device	*dev[2];
+	struct device	*dev, *dev2;
 
 	int		(*init_chipset)(struct pci_dev *);
 
