From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pci: rename __pci_reenable_device() to pci_reenable_device()
Date: Fri, 27 Jul 2007 14:43:35 +0900
Message-ID: <46A98607.7000401@gmail.com>
References: <20070710063605.GA21994@htj.dyndns.org>	<20070710065543.GA23568@htj.dyndns.org>	<46A66842.6040803@garzik.org> <20070724225747.1dd4d141@the-village.bc.nu> <46A677C3.9090107@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:8576 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395AbXG0Fnm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 01:43:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so836967wah
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 22:43:41 -0700 (PDT)
In-Reply-To: <46A677C3.9090107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Rename __pci_reenable_device() to pci_reenable_device().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, Greg wanted to drop the preceding underscores before exporting
the function and the updated patch was posted but the earlier version
was applied.  This patch renames the function.

 drivers/ata/ata_piix.c   |    6 +++---
 drivers/pci/pci-driver.c |    2 +-
 drivers/pci/pci.c        |    7 +++----
 include/linux/pci.h      |    2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -973,10 +973,10 @@ static int piix_pci_device_resume(struct
 		pci_restore_state(pdev);
 
 		/* PCI device wasn't disabled during suspend.  Use
-		 * __pci_reenable_device() to avoid affecting the
-		 * enable count.
+		 * pci_reenable_device() to avoid affecting the enable
+		 * count.
 		 */
-		rc = __pci_reenable_device(pdev);
+		rc = pci_reenable_device(pdev);
 		if (rc)
 			dev_printk(KERN_ERR, &pdev->dev, "failed to enable "
 				   "device after resume (%d)\n", rc);
Index: work/drivers/pci/pci-driver.c
===================================================================
--- work.orig/drivers/pci/pci-driver.c
+++ work/drivers/pci/pci-driver.c
@@ -310,7 +310,7 @@ static int pci_default_resume(struct pci
 	/* restore the PCI config space */
 	pci_restore_state(pci_dev);
 	/* if the device was enabled before suspend, reenable */
-	retval = __pci_reenable_device(pci_dev);
+	retval = pci_reenable_device(pci_dev);
 	/* if the device was busmaster before the suspend, make it busmaster again */
 	if (pci_dev->is_busmaster)
 		pci_set_master(pci_dev);
Index: work/drivers/pci/pci.c
===================================================================
--- work.orig/drivers/pci/pci.c
+++ work/drivers/pci/pci.c
@@ -695,14 +695,13 @@ static int do_pci_enable_device(struct p
 }
 
 /**
- * __pci_reenable_device - Resume abandoned device
+ * pci_reenable_device - Resume abandoned device
  * @dev: PCI device to be resumed
  *
  *  Note this function is a backend of pci_default_resume and is not supposed
  *  to be called by normal code, write proper resume handler and use it instead.
  */
-int
-__pci_reenable_device(struct pci_dev *dev)
+int pci_reenable_device(struct pci_dev *dev)
 {
 	if (atomic_read(&dev->enable_cnt))
 		return do_pci_enable_device(dev, (1 << PCI_NUM_RESOURCES) - 1);
@@ -1604,7 +1603,7 @@ early_param("pci", pci_setup);
 device_initcall(pci_init);
 
 EXPORT_SYMBOL_GPL(pci_restore_bars);
-EXPORT_SYMBOL(__pci_reenable_device);
+EXPORT_SYMBOL(pci_reenable_device);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pcim_enable_device);
Index: work/include/linux/pci.h
===================================================================
--- work.orig/include/linux/pci.h
+++ work/include/linux/pci.h
@@ -534,7 +534,7 @@ static inline int pci_write_config_dword
 
 int __must_check pci_enable_device(struct pci_dev *dev);
 int __must_check pci_enable_device_bars(struct pci_dev *dev, int mask);
-int __must_check __pci_reenable_device(struct pci_dev *);
+int __must_check pci_reenable_device(struct pci_dev *);
 int __must_check pcim_enable_device(struct pci_dev *pdev);
 void pcim_pin_device(struct pci_dev *pdev);
 
