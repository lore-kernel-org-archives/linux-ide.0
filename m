From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 21/50] amd74xx: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:31 +0200
Message-ID: <48710246.1ade660a.3458.629a@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:49197 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758331AbYGFRfE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:04 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309131gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:03 -0700 (PDT)
Content-Disposition: inline; filename=amd74xx-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/amd74xx.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -341,6 +341,7 @@ static struct pci_driver driver = {
 	.name		= "AMD_IDE",
 	.id_table	= amd74xx_pci_tbl,
 	.probe		= amd74xx_probe,
+	.remove		= ide_pci_remove,
 };
 
 static int __init amd74xx_ide_init(void)
@@ -348,7 +349,13 @@ static int __init amd74xx_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit amd74xx_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(amd74xx_ide_init);
+module_exit(amd74xx_ide_exit);
 
 MODULE_AUTHOR("Vojtech Pavlik");
 MODULE_DESCRIPTION("AMD PCI IDE driver");

-- 

