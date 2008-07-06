From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 38/50] rz1000: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:48 +0200
Message-ID: <4871025f.1ade660a.3458.62cd@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:55163 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772AbYGFRf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:29 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309169gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:28 -0700 (PDT)
Content-Disposition: inline; filename=rz1000-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/rz1000.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/rz1000.c
===================================================================
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -62,6 +62,7 @@ static struct pci_driver driver = {
 	.name		= "RZ1000_IDE",
 	.id_table	= rz1000_pci_tbl,
 	.probe		= rz1000_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init rz1000_ide_init(void)
@@ -69,7 +70,13 @@ static int __init rz1000_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit rz1000_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(rz1000_ide_init);
+module_exit(rz1000_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for RZ1000 IDE");

-- 

