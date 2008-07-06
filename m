From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 35/50] pdc202xx_new: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:45 +0200
Message-ID: <4871025a.1ade660a.3458.62c3@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:6749 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432AbYGFRfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:24 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554745mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:23 -0700 (PDT)
Content-Disposition: inline; filename=pdc202xx_new-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_new.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -543,6 +543,15 @@ static int __devinit pdc202new_init_one(
 	return ide_pci_init_one(dev, d, NULL);
 }
 
+static void __devexit pdc202new_remove(struct pci_dev *dev)
+{
+	struct ide_host *host = pci_get_drvdata(dev);
+	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
+
+	ide_pci_remove(dev);
+	pci_dev_put(dev2);
+}
+
 static const struct pci_device_id pdc202new_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20268), 0 },
 	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20269), 1 },
@@ -559,6 +568,7 @@ static struct pci_driver driver = {
 	.name		= "Promise_IDE",
 	.id_table	= pdc202new_pci_tbl,
 	.probe		= pdc202new_init_one,
+	.remove		= pdc202new_remove,
 };
 
 static int __init pdc202new_ide_init(void)
@@ -566,7 +576,13 @@ static int __init pdc202new_ide_init(voi
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit pdc202new_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(pdc202new_ide_init);
+module_exit(pdc202new_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick, Frank Tiernan");
 MODULE_DESCRIPTION("PCI driver module for Promise PDC20268 and higher");

-- 

