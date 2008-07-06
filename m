From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 47/50] trm290: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:57 +0200
Message-ID: <4871026b.1ade660a.3458.62e5@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:6827 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759127AbYGFRfl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:41 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554767mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:40 -0700 (PDT)
Content-Disposition: inline; filename=trm290-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/trm290.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -353,6 +353,7 @@ static struct pci_driver driver = {
 	.name		= "TRM290_IDE",
 	.id_table	= trm290_pci_tbl,
 	.probe		= trm290_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init trm290_ide_init(void)
@@ -360,7 +361,13 @@ static int __init trm290_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit trm290_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(trm290_ide_init);
+module_exit(trm290_ide_exit);
 
 MODULE_AUTHOR("Mark Lord");
 MODULE_DESCRIPTION("PCI driver module for Tekram TRM290 IDE");

-- 

