From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 46/50] triflex: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:56 +0200
Message-ID: <4871026a.1ade660a.3458.62e2@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7307 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759119AbYGFRfk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:40 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985695ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:39 -0700 (PDT)
Content-Disposition: inline; filename=triflex-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/triflex.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -117,6 +117,7 @@ static struct pci_driver driver = {
 	.name		= "TRIFLEX_IDE",
 	.id_table	= triflex_pci_tbl,
 	.probe		= triflex_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init triflex_ide_init(void)
@@ -124,7 +125,13 @@ static int __init triflex_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit triflex_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(triflex_ide_init);
+module_exit(triflex_ide_exit);
 
 MODULE_AUTHOR("Torben Mathiasen");
 MODULE_DESCRIPTION("PCI driver module for Compaq Triflex IDE");

-- 

