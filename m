From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 48/50] via82cxxx: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:58 +0200
Message-ID: <4871026c.1ade660a.3458.62e7@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13310 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432AbYGFRfm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:42 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985611ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:41 -0700 (PDT)
Content-Disposition: inline; filename=via82cxxx-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/via82cxxx.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -467,6 +467,15 @@ static int __devinit via_init_one(struct
 	return rc;
 }
 
+static void __devexit via_remove(struct pci_dev *dev)
+{
+	struct ide_host *host = pci_get_drvdata(dev);
+	struct via82cxxx_dev *vdev = host->host_priv;
+
+	ide_pci_remove(dev);
+	kfree(vdev);
+}
+
 static const struct pci_device_id via_pci_tbl[] = {
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C576_1),  0 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C586_1),  0 },
@@ -481,6 +490,7 @@ static struct pci_driver driver = {
 	.name 		= "VIA_IDE",
 	.id_table 	= via_pci_tbl,
 	.probe 		= via_init_one,
+	.remove		= via_remove,
 };
 
 static int __init via_ide_init(void)
@@ -488,7 +498,13 @@ static int __init via_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit via_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(via_ide_init);
+module_exit(via_ide_exit);
 
 MODULE_AUTHOR("Vojtech Pavlik, Michel Aubry, Jeff Garzik, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for VIA IDE");

-- 

