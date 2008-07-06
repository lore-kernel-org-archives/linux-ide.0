From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 43/50] sl82c105: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:53 +0200
Message-ID: <48710266.1ade660a.3458.62dc@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:6749 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759050AbYGFRfg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:36 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554745mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:35 -0700 (PDT)
Content-Disposition: inline; filename=sl82c105-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sl82c105.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -348,6 +348,7 @@ static struct pci_driver driver = {
 	.name		= "W82C105_IDE",
 	.id_table	= sl82c105_pci_tbl,
 	.probe		= sl82c105_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init sl82c105_ide_init(void)
@@ -355,7 +356,13 @@ static int __init sl82c105_ide_init(void
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit sl82c105_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(sl82c105_ide_init);
+module_exit(sl82c105_ide_exit);
 
 MODULE_DESCRIPTION("PCI driver module for W82C105 IDE");
 MODULE_LICENSE("GPL");

-- 

