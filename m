From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 24/50] cs5530: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:34 +0200
Message-ID: <4871024a.1ade660a.3458.629e@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758475AbYGFRfH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:07 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985609ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:07 -0700 (PDT)
Content-Disposition: inline; filename=cs5530-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5530.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -269,6 +269,7 @@ static struct pci_driver driver = {
 	.name		= "CS5530 IDE",
 	.id_table	= cs5530_pci_tbl,
 	.probe		= cs5530_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init cs5530_ide_init(void)
@@ -276,7 +277,13 @@ static int __init cs5530_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit cs5530_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(cs5530_ide_init);
+module_exit(cs5530_ide_exit);
 
 MODULE_AUTHOR("Mark Lord");
 MODULE_DESCRIPTION("PCI driver module for Cyrix/NS 5530 IDE");

-- 

