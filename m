From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 41/50] siimage: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:51 +0200
Message-ID: <48710264.1ade660a.3458.62d8@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:50837 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759014AbYGFRfe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:34 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309127gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:33 -0700 (PDT)
Content-Disposition: inline; filename=siimage-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/siimage.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -800,6 +800,24 @@ static int __devinit siimage_init_one(st
 	return rc;
 }
 
+static void __devexit siimage_remove(struct pci_dev *dev)
+{
+	struct ide_host *host = pci_get_drvdata(dev);
+	void __iomem *ioaddr = host->host_priv;
+
+	ide_pci_remove(dev);
+
+	if (ioaddr) {
+		resource_size_t bar5 = pci_resource_start(dev, 5);
+		unsigned long barsize = pci_resource_len(dev, 5);
+
+		iounmap(ioaddr);
+		release_mem_region(bar5, barsize);
+	}
+
+	pci_disable_device(dev);
+}
+
 static const struct pci_device_id siimage_pci_tbl[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680),    0 },
 #ifdef CONFIG_BLK_DEV_IDE_SATA
@@ -814,6 +832,7 @@ static struct pci_driver driver = {
 	.name		= "SiI_IDE",
 	.id_table	= siimage_pci_tbl,
 	.probe		= siimage_init_one,
+	.remove		= siimage_remove,
 };
 
 static int __init siimage_ide_init(void)
@@ -821,7 +840,13 @@ static int __init siimage_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit siimage_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(siimage_ide_init);
+module_exit(siimage_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for SiI IDE");

-- 

