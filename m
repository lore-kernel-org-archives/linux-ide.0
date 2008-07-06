From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 22/50] atiixp: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:32 +0200
Message-ID: <48710247.1ade660a.3458.629b@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13310 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758518AbYGFRfF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985611ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:04 -0700 (PDT)
Content-Disposition: inline; filename=atiixp-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/atiixp.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -184,6 +184,7 @@ static struct pci_driver driver = {
 	.name		= "ATIIXP_IDE",
 	.id_table	= atiixp_pci_tbl,
 	.probe		= atiixp_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init atiixp_ide_init(void)
@@ -191,7 +192,13 @@ static int __init atiixp_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit atiixp_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(atiixp_ide_init);
+module_exit(atiixp_ide_exit);
 
 MODULE_AUTHOR("HUI YU");
 MODULE_DESCRIPTION("PCI driver module for ATI IXP IDE");

-- 

