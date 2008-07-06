From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 28/50] hpt34x: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:38 +0200
Message-ID: <4871024e.1ade660a.3458.62a9@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758109AbYGFRfM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:12 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985609ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:11 -0700 (PDT)
Content-Disposition: inline; filename=hpt34x-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/hpt34x.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -169,6 +169,7 @@ static struct pci_driver driver = {
 	.name		= "HPT34x_IDE",
 	.id_table	= hpt34x_pci_tbl,
 	.probe		= hpt34x_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init hpt34x_ide_init(void)
@@ -176,7 +177,13 @@ static int __init hpt34x_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit hpt34x_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(hpt34x_ide_init);
+module_exit(hpt34x_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for Highpoint 34x IDE");

-- 

