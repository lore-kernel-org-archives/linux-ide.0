From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 25/50] cs5535: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:35 +0200
Message-ID: <4871024b.1ade660a.3458.62a1@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:50363 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526AbYGFRfJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:09 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309123gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:08 -0700 (PDT)
Content-Disposition: inline; filename=cs5535-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5535.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -194,6 +194,7 @@ static struct pci_driver driver = {
 	.name       = "CS5535_IDE",
 	.id_table   = cs5535_pci_tbl,
 	.probe      = cs5535_init_one,
+	.remove     = ide_pci_remove,
 };
 
 static int __init cs5535_ide_init(void)
@@ -201,7 +202,13 @@ static int __init cs5535_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit cs5535_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(cs5535_ide_init);
+module_exit(cs5535_ide_exit);
 
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("PCI driver module for AMD/NS CS5535 IDE");

-- 

