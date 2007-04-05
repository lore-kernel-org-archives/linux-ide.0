From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] IDE: fix PCI must_checks
Date: Wed, 4 Apr 2007 21:37:04 -0700
Message-ID: <20070404213704.224128ec.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:24514 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161142AbXDEEfO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Apr 2007 00:35:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: bzolnier@gmail.com, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Check PCI interface function results for errors in drivers/ide/pci.

drivers/ide/pci/cs5530.c:244: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result

drivers/ide/pci/sc1200.c:397: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result

drivers/ide/setup-pci.c:861: warning: ignoring return value of '__pci_register_driver', declared with attribute warn_unused_result

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ide/pci/cs5530.c |    4 +++-
 drivers/ide/pci/sc1200.c |    8 +++++++-
 drivers/ide/setup-pci.c  |    6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

--- linux-2.6.21-rc5-mm4.orig/drivers/ide/pci/cs5530.c
+++ linux-2.6.21-rc5-mm4/drivers/ide/pci/cs5530.c
@@ -236,7 +236,9 @@ static unsigned int __devinit init_chips
 	 */
 
 	pci_set_master(cs5530_0);
-	pci_set_mwi(cs5530_0);
+	if (pci_set_mwi(cs5530_0))
+		printk(KERN_WARNING "%s: error enabling PCI MWI transactions\n",
+			name);
 
 	/*
 	 * Set PCI CacheLineSize to 16-bytes:
--- linux-2.6.21-rc5-mm4.orig/drivers/ide/pci/sc1200.c
+++ linux-2.6.21-rc5-mm4/drivers/ide/pci/sc1200.c
@@ -382,10 +382,16 @@ static int sc1200_suspend (struct pci_de
 static int sc1200_resume (struct pci_dev *dev)
 {
 	ide_hwif_t	*hwif = NULL;
+	int		err;
 
 	pci_set_power_state(dev, PCI_D0);	// bring chip back from sleep state
 	dev->current_state = PM_EVENT_ON;
-	pci_enable_device(dev);
+	err = pci_enable_device(dev);
+	if (err) {
+		printk(KERN_ERR "SC1200: cannot enable device for resume\n");
+		return err;
+	}
+
 	//
 	// loop over all interfaces that are part of this pci device:
 	//
--- linux-2.6.21-rc5-mm4.orig/drivers/ide/setup-pci.c
+++ linux-2.6.21-rc5-mm4/drivers/ide/setup-pci.c
@@ -874,9 +874,13 @@ void __init ide_scan_pcibus (int scan_di
 
 	list_for_each_safe(l, n, &ide_pci_drivers)
 	{
+		int err;
 		list_del(l);
 		d = list_entry(l, struct pci_driver, node);
-		__pci_register_driver(d, d->driver.owner, d->driver.mod_name);
+		err = __pci_register_driver(d, d->driver.owner, d->driver.mod_name);
+		if (err)
+			printk(KERN_ERR "%s: failed to register PCI driver\n",
+				d->driver.mod_name);
 	}
 }
 #endif
