From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH] ide-pci-generic: kill the unused ifdef/endif/MODULE code
Date: Sat,  2 Feb 2008 16:52:36 +0800
Message-ID: <1201942356-26897-1-git-send-email-crquan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:28041 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYBBIw2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 03:52:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so997481rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 02 Feb 2008 00:52:28 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

with module_param macro, the __setup code can be killed now:
	const __setup("all-generic-ide", ide_generic_all_on);

and the module name "generic.ko" is not descriptive to its functionality,
can be changed in Makefile, the "ide-pci-generic.ko" is better.

the ide-pci-generic.all-generic-ide parameter also documented
in Documentation/kernel-parameters.txt

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 Documentation/kernel-parameters.txt |    3 +++
 drivers/ide/pci/Makefile            |    3 ++-
 drivers/ide/pci/generic.c           |   13 -------------
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index cf38689..e81bcae 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -780,6 +780,9 @@ and is between 256 and 4096 characters. It is defined in the file
 			loop use the MONITOR/MWAIT idle loop anyways. Performance should be the same
 			as idle=poll.
 
+	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
+			Claim all unknown PCI IDE storage controllers.
+
 	ignore_loglevel	[KNL]
 			Ignore loglevel setting - this will print /all/
 			kernel messages to the console. Useful for debugging.
diff --git a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
index 9480325..02e6ee7 100644
--- a/drivers/ide/pci/Makefile
+++ b/drivers/ide/pci/Makefile
@@ -34,7 +34,8 @@ obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
 obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+= via82cxxx.o
 
 # Must appear at the end of the block
-obj-$(CONFIG_BLK_DEV_GENERIC)          += generic.o
+obj-$(CONFIG_BLK_DEV_GENERIC)		+= ide-pci-generic.o
+ide-pci-generic-y			+= generic.o
 
 ifeq ($(CONFIG_BLK_DEV_CMD640), m)
 	obj-m += cmd640.o
diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
index 59ebe84..619912e 100644
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -36,19 +36,6 @@
 
 static int ide_generic_all;		/* Set to claim all devices */
 
-/*
- * the module_param_named() was added for the modular case
- * the __setup() is left as compatibility for existing setups
- */
-#ifndef MODULE
-static int __init ide_generic_all_on(char *unused)
-{
-	ide_generic_all = 1;
-	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
-	return 1;
-}
-const __setup("all-generic-ide", ide_generic_all_on);
-#endif
 module_param_named(all_generic_ide, ide_generic_all, bool, 0444);
 MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE storage controllers.");
 
-- 
1.5.3.8

