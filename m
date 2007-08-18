From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: fix PCI refcounting
Date: Sat, 18 Aug 2007 23:15:46 +0400
Message-ID: <200708182315.46802.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:20767 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756954AbXHRTNW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:13:22 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The IDE core never marked the PCI IDE devices as being in use after succesfull
driver probe call (the devices were marked in use only while being probed), and
so was susceptible to issues caused by unsolicited PCI hotplug device removal.
So, add pci_dev_get() call to ide_scan_pcidev() and convert this function to
the kernel style, also dropping a bunch of useless curly braces from its caller,
ide_scan_pcibus() and somewhat beautifying printk() call there, while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Posting as promised (with a free bonus of 2 pdc202xx_new patches ;-).
This patch is also against the current Linus' tree.

 drivers/ide/setup-pci.c |   41 ++++++++++++++++-------------------------
 1 files changed, 16 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/ide/setup-pci.c
===================================================================
--- linux-2.6.orig/drivers/ide/setup-pci.c
+++ linux-2.6/drivers/ide/setup-pci.c
@@ -816,19 +816,15 @@ static int __init ide_scan_pcidev(struct
 	struct list_head *l;
 	struct pci_driver *d;
 	
-	list_for_each(l, &ide_pci_drivers)
-	{
+	list_for_each(l, &ide_pci_drivers) {
 		d = list_entry(l, struct pci_driver, node);
-		if(d->id_table)
-		{
-			const struct pci_device_id *id = pci_match_id(d->id_table, dev);
-			if(id != NULL)
-			{
-				if(d->probe(dev, id) >= 0)
-				{
-					dev->driver = d;
-					return 1;
-				}
+		if (d->id_table) {
+			const struct pci_device_id *id = pci_match_id(d->id_table,
+								      dev);
+			if (id != NULL && d->probe(dev, id) >= 0) {
+				dev->driver = d;
+				pci_dev_get(dev);
+				return 1;
 			}
 		}
 	}
@@ -851,15 +847,13 @@ void __init ide_scan_pcibus (int scan_di
 	struct list_head *l, *n;
 
 	pre_init = 0;
-	if (!scan_direction) {
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	if (!scan_direction)
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 			ide_scan_pcidev(dev);
-		}
-	} else {
-		while ((dev = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	else
+		while ((dev = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, dev))
+		       != NULL)
 			ide_scan_pcidev(dev);
-		}
-	}
 	
 	/*
 	 *	Hand the drivers over to the PCI layer now we
@@ -869,12 +863,9 @@ void __init ide_scan_pcibus (int scan_di
 	list_for_each_safe(l, n, &ide_pci_drivers) {
 		list_del(l);
 		d = list_entry(l, struct pci_driver, node);
-		if (__pci_register_driver(d, d->driver.owner,
-					d->driver.mod_name)) {
-			printk(KERN_ERR "%s: failed to register driver "
-					"for %s\n", __FUNCTION__,
-					 d->driver.mod_name);
-		}
+		if (__pci_register_driver(d, d->driver.owner, d->driver.mod_name))
+			printk(KERN_ERR "%s: failed to register driver for %s\n",
+			       __FUNCTION__, d->driver.mod_name);
 	}
 }
 #endif

