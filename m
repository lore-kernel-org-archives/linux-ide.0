From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 40/50] serverworks: add ->remove method and module_exit()
Date: Sun, 06 Jul 2008 19:20:50 +0200
Message-ID: <48710263.1ade660a.3458.62d6@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759000AbYGFRfd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:33 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985609ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:32 -0700 (PDT)
Content-Disposition: inline; filename=serverworks-add-remove-method-and-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/serverworks.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -439,6 +439,7 @@ static struct pci_driver driver = {
 	.name		= "Serverworks_IDE",
 	.id_table	= svwks_pci_tbl,
 	.probe		= svwks_init_one,
+	.remove		= ide_pci_remove,
 };
 
 static int __init svwks_ide_init(void)
@@ -446,7 +447,13 @@ static int __init svwks_ide_init(void)
 	return ide_pci_register_driver(&driver);
 }
 
+static void __exit svwks_ide_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
 module_init(svwks_ide_init);
+module_exit(svwks_ide_exit);
 
 MODULE_AUTHOR("Michael Aubry. Andrzej Krzysztofowicz, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for Serverworks OSB4/CSB5/CSB6 IDE");

-- 

