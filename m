From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/8] ide: coding style fixes for drivers/ide/setup-pci.c
Date: Thu, 29 Nov 2007 01:07:00 +0100
Message-ID: <200711290107.00292.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:44019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbXK2ACu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659756ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* remove trailing whitespaces
* 'if()' -> 'if ()'
* remove extra new-line before EXPORT_SYMBOL_GPL()
* add extra new-line after 'id' definition
* respect 80-columns limit

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -703,7 +703,7 @@ EXPORT_SYMBOL_GPL(ide_setup_pci_devices)
 /*
  *	Module interfaces
  */
- 
+
 static int pre_init = 1;		/* Before first ordered IDE scan */
 static LIST_HEAD(ide_pci_drivers);
 
@@ -713,7 +713,7 @@ static LIST_HEAD(ide_pci_drivers);
  *	@module: owner module of the driver
  *
  *	Registers a driver with the IDE layer. The IDE layer arranges that
- *	boot time setup is done in the expected device order and then 
+ *	boot time setup is done in the expected device order and then
  *	hands the controllers off to the core PCI code to do the rest of
  *	the work.
  *
@@ -723,13 +723,12 @@ static LIST_HEAD(ide_pci_drivers);
 int __ide_pci_register_driver(struct pci_driver *driver, struct module *module,
 			      const char *mod_name)
 {
-	if(!pre_init)
+	if (!pre_init)
 		return __pci_register_driver(driver, module, mod_name);
 	driver->driver.owner = module;
 	list_add_tail(&driver->node, &ide_pci_drivers);
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
 
 /**
@@ -740,17 +739,18 @@ EXPORT_SYMBOL_GPL(__ide_pci_register_dri
  *	This is only used during boot up to get the ordering correct. After
  *	boot up the pci layer takes over the job.
  */
- 
+
 static int __init ide_scan_pcidev(struct pci_dev *dev)
 {
 	struct list_head *l;
 	struct pci_driver *d;
-	
+
 	list_for_each(l, &ide_pci_drivers) {
 		d = list_entry(l, struct pci_driver, node);
 		if (d->id_table) {
-			const struct pci_device_id *id = pci_match_id(d->id_table,
-								      dev);
+			const struct pci_device_id *id =
+				pci_match_id(d->id_table, dev);
+
 			if (id != NULL && d->probe(dev, id) >= 0) {
 				dev->driver = d;
 				pci_dev_get(dev);
@@ -777,13 +777,13 @@ int __init ide_scan_pcibus(void)
 
 	pre_init = 0;
 	if (!ide_scan_direction)
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)))
 			ide_scan_pcidev(dev);
 	else
-		while ((dev = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, dev))
-		       != NULL)
+		while ((dev = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID,
+						     dev)))
 			ide_scan_pcidev(dev);
-	
+
 	/*
 	 *	Hand the drivers over to the PCI layer now we
 	 *	are post init.
