From: Jeremy Higdon <jeremy@sgi.com>
Subject: [PATCH 1/1] sgiioc4: Disable module unload
Date: Mon, 20 Nov 2006 19:15:52 -0800
Message-ID: <20061121031552.GA73433@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:56715 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030676AbWKUDPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Nov 2006 22:15:52 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, akpm@osdl.org

This patch removes a module_exit function that it sgiioc4 should not have had.

Signed-off-by: Jeremy Higdon <jeremy@sgi.com>


--- linux-2.6.19-rc6/drivers/ide/pci/sgiioc4.c	2006-11-15 20:03:40.000000000 -0800
+++ linux-2.6.19-rc6-mod/drivers/ide/pci/sgiioc4.c	2006-11-20 18:45:08.506724280 -0800
@@ -768,14 +768,7 @@
 	return ioc4_register_submodule(&ioc4_ide_submodule);
 }
 
-static void __devexit
-ioc4_ide_exit(void)
-{
-	ioc4_unregister_submodule(&ioc4_ide_submodule);
-}
-
 late_initcall(ioc4_ide_init); /* Call only after IDE init is done */
-module_exit(ioc4_ide_exit);
 
 MODULE_AUTHOR("Aniket Malatpure/Jeremy Higdon");
 MODULE_DESCRIPTION("IDE PCI driver module for SGI IOC4 Base-IO Card");
