From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 37/50] piix: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:47 +0200
Message-ID: <4871025d.1ade660a.3458.62ca@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:41596 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913AbYGFRf1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:27 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309132gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:27 -0700 (PDT)
Content-Disposition: inline; filename=piix-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/piix.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -462,6 +462,7 @@ static struct pci_driver driver = {
 	.name		= "PIIX_IDE",
 	.id_table	= piix_pci_tbl,
 	.probe		= piix_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init piix_ide_init(void)
@@ -470,7 +471,13 @@ static int __init piix_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit piix_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(piix_ide_init);
+module_exit(piix_ide_exit);
 
 MODULE_AUTHOR("Andre Hedrick, Andrzej Krzysztofowicz");
 MODULE_DESCRIPTION("PCI driver module for Intel PIIX IDE");

-- 

