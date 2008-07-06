From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 27/50] ide/pci/generic: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:37 +0200
Message-ID: <4871024d.1ade660a.3458.62a7@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:41596 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbYGFRfL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:11 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309132gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:10 -0700 (PDT)
Content-Disposition: inline; filename=generic-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/generic.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -174,6 +174,7 @@ static struct pci_driver driver = {
 	.name		= "PCI_IDE",
 	.id_table	= generic_pci_tbl,
 	.probe		= generic_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init generic_ide_init(void)
@@ -181,7 +182,13 @@ static int __init generic_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit generic_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(generic_ide_init);
+module_exit(generic_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for generic PCI IDE");

-- 

