From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] allow modular ide-pnp
Date: Mon, 5 Jul 2004 12:47:21 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040705104721.GA30162@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([212.34.189.10]:44933 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266010AbUGEKr2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2004 06:47:28 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org
Cc: linux-ide@vger.kernel.org

Original patch from Herbert Xu, almost completely redone by me ;-)

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
--- 1.21/drivers/ide/Makefile	2004-06-18 08:43:53 +02:00
+++ edited/drivers/ide/Makefile	2004-06-19 12:42:49 +02:00
@@ -23,7 +23,6 @@
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
 ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
-ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
 # built-in only drivers from arm/
 ide-core-$(CONFIG_IDE_ARM)		+= arm/ide_arm.o
@@ -44,6 +43,7 @@
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
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
