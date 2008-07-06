From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/50] aec62xx: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:29 +0200
Message-ID: <48710244.1ade660a.3458.6295@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:6801 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758405AbYGFRfB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:01 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554720mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:01 -0700 (PDT)
Content-Disposition: inline; filename=aec62xx-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -280,6 +280,12 @@ static int __devinit aec62xx_init_one(st
 	return err;
 }
 
+static void __devexit aec62xx_remove(struct pci_dev *dev)
+{
+	ide_pci_remove(dev);
+	pci_disable_device(dev);
+}
+
 static const struct pci_device_id aec62xx_pci_tbl[] = {
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF), 0 },
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP860),   1 },
@@ -294,6 +300,7 @@ static struct pci_driver driver = {
 	.name		= "AEC62xx_IDE",
 	.id_table	= aec62xx_pci_tbl,
 	.probe		= aec62xx_init_one,
+	.remove		= aec62xx_remove,
 };
 
 static int __init aec62xx_ide_init(void)
@@ -301,7 +308,13 @@ static int __init aec62xx_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit aec62xx_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(aec62xx_ide_init);
+module_exit(aec62xx_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for ARTOP AEC62xx IDE");

-- 

