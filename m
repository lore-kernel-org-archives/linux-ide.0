From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ide: unregister idepnp driver on unload
Date: Thu, 18 Jan 2007 17:19:25 +0900
Message-ID: <20070118081925.GQ10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:35428 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbXARITa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Jan 2007 03:19:30 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org

idepnp driver is registered as a pnp driver on ide init but doesn't
get unregistered on ide unload causing driver list corruption and
eventually oops.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
diff --git a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
index df7d150..98410ca 100644
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -73,3 +73,8 @@ void __init pnpide_init(void)
 {
 	pnp_register_driver(&idepnp_driver);
 }
+
+void __exit pnpide_exit(void)
+{
+	pnp_unregister_driver(&idepnp_driver);
+}
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 1689076..3b334af 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1782,6 +1782,7 @@ done:
 }
 
 extern void pnpide_init(void);
+extern void pnpide_exit(void);
 extern void h8300_ide_init(void);
 
 /*
@@ -2094,6 +2095,10 @@ void cleanup_module (void)
 	for (index = 0; index < MAX_HWIFS; ++index)
 		ide_unregister(index);
 
+#ifdef CONFIG_BLK_DEV_IDEPNP
+	pnpide_exit();
+#endif
+
 #ifdef CONFIG_PROC_FS
 	proc_ide_destroy();
 #endif
