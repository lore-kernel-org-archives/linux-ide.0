From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 30/50] it8213: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:40 +0200
Message-ID: <48710250.1ade660a.3458.62ae@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:50837 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486AbYGFRfP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:15 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309127gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:14 -0700 (PDT)
Content-Disposition: inline; filename=it8213-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it8213.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -198,6 +198,7 @@ static struct pci_driver driver = {
 	.name		= "ITE8213_IDE",
 	.id_table	= it8213_pci_tbl,
 	.probe		= it8213_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init it8213_ide_init(void)
@@ -205,7 +206,13 @@ static int __init it8213_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit it8213_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(it8213_ide_init);
+module_exit(it8213_ide_exit);
 
 MODULE_AUTHOR("Jack Lee, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for the ITE 8213");

-- 

