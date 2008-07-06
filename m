From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 32/50] jmicron: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:42 +0200
Message-ID: <48710253.1ade660a.3458.62b3@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:55163 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401AbYGFRfR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:17 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309169gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:16 -0700 (PDT)
Content-Disposition: inline; filename=jmicron-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/jmicron.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -152,6 +152,7 @@ static struct pci_driver driver = {
 	.name		= "JMicron IDE",
 	.id_table	= jmicron_pci_tbl,
 	.probe		= jmicron_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init jmicron_ide_init(void)
@@ -159,7 +160,13 @@ static int __init jmicron_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit jmicron_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(jmicron_ide_init);
+module_exit(jmicron_ide_exit);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for the JMicron in legacy modes");

-- 

