From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 31/50] it821x: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:41 +0200
Message-ID: <48710252.1ade660a.3458.62b0@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:41596 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbYGFRfR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:17 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309132gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:15 -0700 (PDT)
Content-Disposition: inline; filename=it821x-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it821x.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -659,6 +659,15 @@ static int __devinit it821x_init_one(str
 	return rc;
 }
 
+static void __devexit it821x_remove(struct pci_dev *dev)
+{
+	struct ide_host *host = pci_get_drvdata(dev);
+	struct it821x_dev *itdevs = host->host_priv;
+
+	ide_pci_remove(dev);
+	kfree(itdevs);
+}
+
 static const struct pci_device_id it821x_pci_tbl[] = {
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8211), 0 },
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8212), 0 },
@@ -671,6 +680,7 @@ static struct pci_driver driver = {
 	.name		= "ITE821x IDE",
 	.id_table	= it821x_pci_tbl,
 	.probe		= it821x_init_one,
+	.remove		= it821x_remove,
 };
 
 static int __init it821x_ide_init(void)
@@ -678,7 +688,13 @@ static int __init it821x_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit it821x_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(it821x_ide_init);
+module_exit(it821x_ide_exit);
 
 module_param_named(noraid, it8212_noraid, int, S_IRUGO);
 MODULE_PARM_DESC(noraid, "Force card into bypass mode");

-- 

