From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 36/50] pdc202xx_old: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:46 +0200
Message-ID: <4871025c.1ade660a.3458.62c7@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:6801 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531AbYGFRfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:25 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554720mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:24 -0700 (PDT)
Content-Disposition: inline; filename=pdc202xx_old-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_old.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -429,6 +429,7 @@ static struct pci_driver driver = {
 	.name		= "Promise_Old_IDE",
 	.id_table	= pdc202xx_pci_tbl,
 	.probe		= pdc202xx_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init pdc202xx_ide_init(void)
@@ -436,7 +437,13 @@ static int __init pdc202xx_ide_init(void
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit pdc202xx_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(pdc202xx_ide_init);
+module_exit(pdc202xx_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick, Frank Tiernan");
 MODULE_DESCRIPTION("PCI driver module for older Promise IDE");

-- 

