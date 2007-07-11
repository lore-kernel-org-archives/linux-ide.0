From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] PCI: rename and export __pci_reenable_device()
Date: Wed, 11 Jul 2007 19:32:04 +0900
Message-ID: <20070711103204.GE23568@htj.dyndns.org>
References: <20070710063605.GA21994@htj.dyndns.org> <20070710161709.GB5421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:53878 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759826AbXGKKcP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 06:32:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1310196nze
        for <linux-ide@vger.kernel.org>; Wed, 11 Jul 2007 03:32:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070710161709.GB5421@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Some odd ACPI implementations choke if certain controller is disabled
when ACPI suspend is invoked but we still need to make sure the PCI
device is enabled during resume.  Simply using pci_enable_device()
unbalances device enable count.

Drop leading underscores from __pci_reenable_device() and export it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Sure, here it is.

 drivers/pci/pci-driver.c |    2 +-
 drivers/pci/pci.c        |    6 +++---
 drivers/pci/pci.h        |    1 -
 include/linux/pci.h      |    1 +
 4 files changed, 5 insertions(+), 5 deletions(-)

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
@@ -1427,6 +1426,7 @@ early_param("pci", pci_setup);
 device_initcall(pci_init);
 
 EXPORT_SYMBOL_GPL(pci_restore_bars);
+EXPORT_SYMBOL(pci_reenable_device);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pcim_enable_device);
Index: work/drivers/pci/pci.h
===================================================================
--- work.orig/drivers/pci/pci.h
+++ work/drivers/pci/pci.h
@@ -1,6 +1,5 @@
 /* Functions internal to the PCI core code */
 
-extern int __must_check __pci_reenable_device(struct pci_dev *);
 extern int pci_uevent(struct device *dev, char **envp, int num_envp,
 		      char *buffer, int buffer_size);
 extern int pci_create_sysfs_dev_files(struct pci_dev *pdev);
Index: work/include/linux/pci.h
===================================================================
--- work.orig/include/linux/pci.h
+++ work/include/linux/pci.h
@@ -531,6 +531,7 @@ static inline int pci_write_config_dword
 
 int __must_check pci_enable_device(struct pci_dev *dev);
 int __must_check pci_enable_device_bars(struct pci_dev *dev, int mask);
+int __must_check pci_reenable_device(struct pci_dev *);
 int __must_check pcim_enable_device(struct pci_dev *pdev);
 void pcim_pin_device(struct pci_dev *pdev);
 
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
