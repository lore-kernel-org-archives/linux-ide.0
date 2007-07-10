From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] PCI: export __pci_reenable_device()
Date: Tue, 10 Jul 2007 15:36:05 +0900
Message-ID: <20070710063605.GA21994@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:13214 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbXGJGgK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 02:36:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1721711wah
        for <linux-ide@vger.kernel.org>; Mon, 09 Jul 2007 23:36:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Some odd ACPI implementations choke if certain controller is disabled
when ACPI suspend is invoked but we still need to make sure the PCI
device is enabled during resume.  Simply using pci_enable_device()
unbalances device enable count.  Export __pci_reenable_device().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/pci/pci.c   |    1 +
 drivers/pci/pci.h   |    1 -
 include/linux/pci.h |    1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

Index: work/drivers/pci/pci.c
===================================================================
--- work.orig/drivers/pci/pci.c
+++ work/drivers/pci/pci.c
@@ -1427,6 +1427,7 @@ early_param("pci", pci_setup);
 device_initcall(pci_init);
 
 EXPORT_SYMBOL_GPL(pci_restore_bars);
+EXPORT_SYMBOL(__pci_reenable_device);
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
+int __must_check __pci_reenable_device(struct pci_dev *);
 int __must_check pcim_enable_device(struct pci_dev *pdev);
 void pcim_pin_device(struct pci_dev *pdev);
 
