From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 23/50] cmd64x: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:33 +0200
Message-ID: <48710248.1ade660a.3458.629d@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:50837 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758522AbYGFRfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:06 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309127gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:06 -0700 (PDT)
Content-Disposition: inline; filename=cmd64x-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd64x.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -505,6 +505,7 @@ static struct pci_driver driver = {
 	.name		= "CMD64x_IDE",
 	.id_table	= cmd64x_pci_tbl,
 	.probe		= cmd64x_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init cmd64x_ide_init(void)
@@ -512,7 +513,13 @@ static int __init cmd64x_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit cmd64x_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(cmd64x_ide_init);
+module_exit(cmd64x_ide_exit);
 
 MODULE_AUTHOR("Eddie Dost, David Miller, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for CMD64x IDE");

-- 

