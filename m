From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 20/50] alim15x3: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:30 +0200
Message-ID: <48710245.1ade660a.3458.6299@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:50837 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448AbYGFRfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:03 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309127gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:02 -0700 (PDT)
Content-Disposition: inline; filename=alim15x3-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -580,6 +580,7 @@ static struct pci_driver driver = {
 	.name		= "ALI15x3_IDE",
 	.id_table	= alim15x3_pci_tbl,
 	.probe		= alim15x3_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init ali15x3_ide_init(void)
@@ -587,7 +588,13 @@ static int __init ali15x3_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit ali15x3_ide_exit(void)
+{
+	return pci_unregister_driver(&driver);
+}
+
 module_init(ali15x3_ide_init);
+module_exit(ali15x3_ide_exit);
 
 MODULE_AUTHOR("Michael Aubry, Andrzej Krzysztofowicz, CJ, Andre Hedrick, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for ALi 15x3 IDE");

-- 

