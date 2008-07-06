From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 39/50] sc1200: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:49 +0200
Message-ID: <48710260.1ade660a.3458.62d0@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:6827 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758989AbYGFRfb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:31 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554767mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:30 -0700 (PDT)
Content-Disposition: inline; filename=sc1200-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sc1200.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -329,6 +329,7 @@ static struct pci_driver driver = {
 	.name		= "SC1200_IDE",
 	.id_table	= sc1200_pci_tbl,
 	.probe		= sc1200_init_one,
+	.remove		= ide_pci_remove,
 #ifdef CONFIG_PM
 	.suspend	= sc1200_suspend,
 	.resume		= sc1200_resume,
@@ -340,7 +341,13 @@ static int __init sc1200_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit sc1200_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(sc1200_ide_init);
+module_exit(sc1200_ide_exit);
 
 MODULE_AUTHOR("Mark Lord");
 MODULE_DESCRIPTION("PCI driver module for NS SC1200 IDE");

-- 

