From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] module ide-pnp
Date: Sat, 19 Jun 2004 12:35:46 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040619103546.GA30487@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([212.34.189.10]:45734 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265476AbUFSKft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jun 2004 06:35:49 -0400
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i5JAZlQc030512
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-ide@vger.kernel.org>; Sat, 19 Jun 2004 12:35:47 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i5JAZkgC030510
	for linux-ide@vger.kernel.org; Sat, 19 Jun 2004 12:35:46 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This patch allows compile ide-pnp as a module.  The original patch is
from Herbert Xu through the Debian kernel package, but I reworked it
significantly.


--- 1.49/drivers/ide/Kconfig	2004-06-18 08:43:53 +02:00
+++ edited/drivers/ide/Kconfig	2004-06-19 12:25:46 +02:00
@@ -305,7 +305,7 @@
 	  Otherwise say N.
 
 config BLK_DEV_IDEPNP
-	bool "PNP EIDE support"
+	tristate "PNP EIDE support"
 	depends on PNP
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
--- 1.9/drivers/ide/ide-pnp.c	2004-06-15 18:31:45 +02:00
+++ edited/drivers/ide/ide-pnp.c	2004-06-19 12:34:27 +02:00
@@ -69,7 +69,21 @@
 	.remove		= idepnp_remove,
 };
 
-void __init pnpide_init(void)
+int __init pnpide_init(void)
 {
-	pnp_register_driver(&idepnp_driver);
+	return pnp_register_driver(&idepnp_driver);
 }
+
+#ifdef MODULE
+static void __exit pnpide_exit(void)
+{
+       pnp_unregister_driver(&idepnp_driver);
+}
+
+module_init(pnpide_init);
+module_exit(pnpide_exit);
+#endif
+
+MODULE_AUTHOR("Andrey Panin");
+MODULE_DESCRIPTION("Enabler for ISAPNP IDE devices");
+MODULE_LICENSE("GPL");
--- 1.150/drivers/ide/ide.c	2004-06-15 18:31:12 +02:00
+++ edited/drivers/ide/ide.c	2004-06-19 12:29:44 +02:00
@@ -2003,7 +2003,7 @@
 	return 1;
 }
 
-extern void pnpide_init(void);
+extern int pnpide_init(void);
 extern void h8300_ide_init(void);
 
 /*
