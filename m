From: maximilian attems <janitor@sternwelten.at>
Subject: [patch] allow modular built of ide-pnp
Date: Sun, 26 Jun 2005 19:42:10 +0200
Message-ID: <20050626174210.GV12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:6073 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S261507AbVFZRmB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 13:42:01 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, hch@lst.de
Cc: linux-ide@vger.kernel.org, ambx1@neo.rr.com

From: Christoph Hellwig <hch@lst.de>

patch is based on previous work of Herbert Xu
and included in current debian kernel images.
allows modular ide-pnp

Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/Kconfig	2005-06-15 22:15:06.000000000 -0400
@@ -315,7 +315,7 @@
 	  Otherwise say N.
 
 config BLK_DEV_IDEPNP
-	bool "PNP EIDE support"
+	tristate "PNP EIDE support"
 	depends on PNP
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
diff -aurN a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/Makefile	2005-06-15 22:15:06.000000000 -0400
@@ -22,7 +22,6 @@
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
 ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
-ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
 # built-in only drivers from arm/
 ide-core-$(CONFIG_IDE_ARM)		+= arm/ide_arm.o
@@ -43,6 +42,7 @@
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
diff -aurN a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
--- a/drivers/ide/ide-pnp.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/ide-pnp.c	2005-06-15 22:15:06.000000000 -0400
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
diff -aurN a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/ide.c	2005-06-15 22:15:06.000000000 -0400
@@ -1789,7 +1789,7 @@
 	return 1;
 }
 
-extern void pnpide_init(void);
+extern int pnpide_init(void);
 extern void h8300_ide_init(void);
 
 /*
