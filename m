From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 45/50] tc86c001: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:55 +0200
Message-ID: <48710269.1ade660a.3458.62e0@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772AbYGFRfj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985692ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:38 -0700 (PDT)
Content-Disposition: inline; filename=tc86c001-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/tc86c001.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -232,6 +232,13 @@ out:
 	return rc;
 }
 
+static void __devexit tc86c001_remove(struct pci_dev *dev)
+{
+	ide_pci_remove(dev);
+	pci_release_region(dev, 5);
+	pci_disable_device(dev);
+}
+
 static const struct pci_device_id tc86c001_pci_tbl[] = {
 	{ PCI_VDEVICE(TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_TC86C001_IDE), 0 },
 	{ 0, }
@@ -241,14 +248,22 @@ MODULE_DEVICE_TABLE(pci, tc86c001_pci_tb
 static struct pci_driver driver = {
 	.name		= "TC86C001",
 	.id_table	= tc86c001_pci_tbl,
-	.probe		= tc86c001_init_one
+	.probe		= tc86c001_init_one,
+	.remove		= tc86c001_remove,
 };
 
 static int __init tc86c001_ide_init(void)
 {
 	return ide_pci_register_driver(&driver);
 }
+
+static void __exit tc86c001_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(tc86c001_ide_init);
+module_exit(tc86c001_ide_exit);
 
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
 MODULE_DESCRIPTION("PCI driver module for TC86C001 IDE");

-- 

