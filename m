From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 34/50] opti621: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:44 +0200
Message-ID: <48710259.1ade660a.3458.62c0@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:50837 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758734AbYGFRfX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:23 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309127gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:22 -0700 (PDT)
Content-Disposition: inline; filename=opti621-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/opti621.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -223,6 +223,7 @@ static struct pci_driver driver = {
 	.name		= "Opti621_IDE",
 	.id_table	= opti621_pci_tbl,
 	.probe		= opti621_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init opti621_ide_init(void)
@@ -230,7 +231,13 @@ static int __init opti621_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit opti621_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(opti621_ide_init);
+module_exit(opti621_ide_exit);
 
 MODULE_AUTHOR("Jaromir Koutek, Jan Harkes, Mark Lord");
 MODULE_DESCRIPTION("PCI driver module for Opti621 IDE");

-- 

