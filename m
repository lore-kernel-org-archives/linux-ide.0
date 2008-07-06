From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 44/50] slc90e66: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:54 +0200
Message-ID: <48710268.1ade660a.3458.62df@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:12326 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759066AbYGFRfi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985690ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:37 -0700 (PDT)
Content-Disposition: inline; filename=slc90e66-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/slc90e66.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -157,6 +157,7 @@ static struct pci_driver driver = {
 	.name		= "SLC90e66_IDE",
 	.id_table	= slc90e66_pci_tbl,
 	.probe		= slc90e66_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init slc90e66_ide_init(void)
@@ -164,7 +165,13 @@ static int __init slc90e66_ide_init(void
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit slc90e66_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(slc90e66_ide_init);
+module_exit(slc90e66_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for SLC90E66 IDE");

-- 

