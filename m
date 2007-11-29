From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/8] ide: move CONFIG_IDEPCI_PCIBUS_ORDER code to ide-scan-pci.c
Date: Thu, 29 Nov 2007 01:07:35 +0100
Message-ID: <200711290107.35463.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:43996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062AbXK2ACv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659751ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-scan-pci.c |  110 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/setup-pci.c    |  103 ------------------------------------------
 2 files changed, 110 insertions(+), 103 deletions(-)

Index: b/drivers/ide/ide-scan-pci.c
===================================================================
--- a/drivers/ide/ide-scan-pci.c
+++ b/drivers/ide/ide-scan-pci.c
@@ -1,8 +1,118 @@
+/*
+ * support for probing IDE PCI devices in the PCI bus order
+ *
+ * Copyright (c) 1998-2000  Andre Hedrick <andre@linux-ide.org>
+ * Copyright (c) 1995-1998  Mark Lord
+ *
+ * May be copied or modified under the terms of the GNU General Public License
+ */
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/ide.h>
 
+/*
+ *	Module interfaces
+ */
+
+static int pre_init = 1;		/* Before first ordered IDE scan */
+static LIST_HEAD(ide_pci_drivers);
+
+/*
+ *	__ide_pci_register_driver	-	attach IDE driver
+ *	@driver: pci driver
+ *	@module: owner module of the driver
+ *
+ *	Registers a driver with the IDE layer. The IDE layer arranges that
+ *	boot time setup is done in the expected device order and then
+ *	hands the controllers off to the core PCI code to do the rest of
+ *	the work.
+ *
+ *	Returns are the same as for pci_register_driver
+ */
+
+int __ide_pci_register_driver(struct pci_driver *driver, struct module *module,
+			      const char *mod_name)
+{
+	if (!pre_init)
+		return __pci_register_driver(driver, module, mod_name);
+	driver->driver.owner = module;
+	list_add_tail(&driver->node, &ide_pci_drivers);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
+
+/**
+ *	ide_scan_pcidev		-	find an IDE driver for a device
+ *	@dev: PCI device to check
+ *
+ *	Look for an IDE driver to handle the device we are considering.
+ *	This is only used during boot up to get the ordering correct. After
+ *	boot up the pci layer takes over the job.
+ */
+
+static int __init ide_scan_pcidev(struct pci_dev *dev)
+{
+	struct list_head *l;
+	struct pci_driver *d;
+
+	list_for_each(l, &ide_pci_drivers) {
+		d = list_entry(l, struct pci_driver, node);
+		if (d->id_table) {
+			const struct pci_device_id *id =
+				pci_match_id(d->id_table, dev);
+
+			if (id != NULL && d->probe(dev, id) >= 0) {
+				dev->driver = d;
+				pci_dev_get(dev);
+				return 1;
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ *	ide_scan_pcibus		-	perform the initial IDE driver scan
+ *
+ *	Perform the initial bus rather than driver ordered scan of the
+ *	PCI drivers. After this all IDE pci handling becomes standard
+ *	module ordering not traditionally ordered.
+ */
+
+int __init ide_scan_pcibus(void)
+{
+	struct pci_dev *dev = NULL;
+	struct pci_driver *d;
+	struct list_head *l, *n;
+
+	pre_init = 0;
+	if (!ide_scan_direction)
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)))
+			ide_scan_pcidev(dev);
+	else
+		while ((dev = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID,
+						     dev)))
+			ide_scan_pcidev(dev);
+
+	/*
+	 *	Hand the drivers over to the PCI layer now we
+	 *	are post init.
+	 */
+
+	list_for_each_safe(l, n, &ide_pci_drivers) {
+		list_del(l);
+		d = list_entry(l, struct pci_driver, node);
+		if (__pci_register_driver(d, d->driver.owner,
+					  d->driver.mod_name))
+			printk(KERN_ERR "%s: failed to register %s driver\n",
+					__FUNCTION__, d->driver.mod_name);
+	}
+
+	return 0;
+}
+
 static int __init ide_scan_pci(void)
 {
 	return ide_scan_pcibus();
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -698,106 +698,3 @@ out:
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_devices);
-
-#ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-/*
- *	Module interfaces
- */
-
-static int pre_init = 1;		/* Before first ordered IDE scan */
-static LIST_HEAD(ide_pci_drivers);
-
-/*
- *	__ide_pci_register_driver	-	attach IDE driver
- *	@driver: pci driver
- *	@module: owner module of the driver
- *
- *	Registers a driver with the IDE layer. The IDE layer arranges that
- *	boot time setup is done in the expected device order and then
- *	hands the controllers off to the core PCI code to do the rest of
- *	the work.
- *
- *	Returns are the same as for pci_register_driver
- */
-
-int __ide_pci_register_driver(struct pci_driver *driver, struct module *module,
-			      const char *mod_name)
-{
-	if (!pre_init)
-		return __pci_register_driver(driver, module, mod_name);
-	driver->driver.owner = module;
-	list_add_tail(&driver->node, &ide_pci_drivers);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
-
-/**
- *	ide_scan_pcidev		-	find an IDE driver for a device
- *	@dev: PCI device to check
- *
- *	Look for an IDE driver to handle the device we are considering.
- *	This is only used during boot up to get the ordering correct. After
- *	boot up the pci layer takes over the job.
- */
-
-static int __init ide_scan_pcidev(struct pci_dev *dev)
-{
-	struct list_head *l;
-	struct pci_driver *d;
-
-	list_for_each(l, &ide_pci_drivers) {
-		d = list_entry(l, struct pci_driver, node);
-		if (d->id_table) {
-			const struct pci_device_id *id =
-				pci_match_id(d->id_table, dev);
-
-			if (id != NULL && d->probe(dev, id) >= 0) {
-				dev->driver = d;
-				pci_dev_get(dev);
-				return 1;
-			}
-		}
-	}
-	return 0;
-}
-
-/**
- *	ide_scan_pcibus		-	perform the initial IDE driver scan
- *
- *	Perform the initial bus rather than driver ordered scan of the
- *	PCI drivers. After this all IDE pci handling becomes standard
- *	module ordering not traditionally ordered.
- */
-
-int __init ide_scan_pcibus(void)
-{
-	struct pci_dev *dev = NULL;
-	struct pci_driver *d;
-	struct list_head *l, *n;
-
-	pre_init = 0;
-	if (!ide_scan_direction)
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)))
-			ide_scan_pcidev(dev);
-	else
-		while ((dev = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID,
-						     dev)))
-			ide_scan_pcidev(dev);
-
-	/*
-	 *	Hand the drivers over to the PCI layer now we
-	 *	are post init.
-	 */
-
-	list_for_each_safe(l, n, &ide_pci_drivers) {
-		list_del(l);
-		d = list_entry(l, struct pci_driver, node);
-		if (__pci_register_driver(d, d->driver.owner,
-					  d->driver.mod_name))
-			printk(KERN_ERR "%s: failed to register %s driver\n",
-					__FUNCTION__, d->driver.mod_name);
-	}
-
-	return 0;
-}
-#endif
