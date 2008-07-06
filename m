From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 42/50] sis5513: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:52 +0200
Message-ID: <48710265.1ade660a.3458.62db@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:13456 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759073AbYGFRfj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985684ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:34 -0700 (PDT)
Content-Disposition: inline; filename=sis5513-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -586,6 +586,12 @@ static int __devinit sis5513_init_one(st
 	return ide_pci_init_one(dev, &d, NULL);
 }
 
+static void __devexit sis5513_remove(struct pci_dev *dev)
+{
+	ide_pci_remove(dev);
+	pci_disable_device(dev);
+}
+
 static const struct pci_device_id sis5513_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_5513), 0 },
 	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_5518), 0 },
@@ -598,6 +604,7 @@ static struct pci_driver driver = {
 	.name		= "SIS_IDE",
 	.id_table	= sis5513_pci_tbl,
 	.probe		= sis5513_init_one,
+	.remove		= sis5513_remove,
 };
 
 static int __init sis5513_ide_init(void)
@@ -605,7 +612,13 @@ static int __init sis5513_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit sis5513_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(sis5513_ide_init);
+module_exit(sis5513_ide_exit);
 
 MODULE_AUTHOR("Lionel Bouton, L C Chang, Andre Hedrick, Vojtech Pavlik");
 MODULE_DESCRIPTION("PCI driver module for SIS IDE");

-- 

