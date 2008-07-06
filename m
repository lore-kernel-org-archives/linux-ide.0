From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 33/50] ns87415: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:43 +0200
Message-ID: <48710254.1ade660a.3458.62b7@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525AbYGFRfV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:21 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985609ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:21 -0700 (PDT)
Content-Disposition: inline; filename=ns87415-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/ns87415.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -341,6 +341,7 @@ static struct pci_driver driver = {
 	.name		= "NS87415_IDE",
 	.id_table	= ns87415_pci_tbl,
 	.probe		= ns87415_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init ns87415_ide_init(void)
@@ -348,7 +349,13 @@ static int __init ns87415_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit ns87415_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(ns87415_ide_init);
+module_exit(ns87415_ide_exit);
 
 MODULE_AUTHOR("Mark Lord, Eddie Dost, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for NS87415 IDE");

-- 

