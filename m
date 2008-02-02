From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH] ide-core: remove conditional compiling with MODULE in ide-core.c
Date: Sat,  2 Feb 2008 15:52:30 +0800
Message-ID: <1201938750-22423-1-git-send-email-crquan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:13785 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYBBHwb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 02:52:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so989439rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 23:52:30 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

use module_init/module_exit to replace the original cond-compiling, these
macros were well designed to deal module/built-in compiling.

the original __setup with null string was invalid and not executed,
	__setup("", ide_setup);

however, with the current module_param mechanics, module parameters also can
be input on the kernel command line, with this style:

	ide-core.options="ide=nodma hdd=cdrom idebus=..."

so Documentation/kernel-parameters.txt also updated.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 Documentation/kernel-parameters.txt |   11 +------
 drivers/ide/ide.c                   |   55 ++++++++++++++--------------------
 2 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index cf38689..c94730c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -759,15 +759,8 @@ and is between 256 and 4096 characters. It is defined in the file
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
-	ide=		[HW] (E)IDE subsystem
-			Format: ide=nodma or ide=doubler or ide=reverse
-			See Documentation/ide.txt.
-
-	ide?=		[HW] (E)IDE subsystem
-			Format: ide?=noprobe or chipset specific parameters.
-			See Documentation/ide.txt.
-
-	idebus=		[HW] (E)IDE subsystem - VLB/PCI bus speed
+	ide-core.options= [HW] (E)IDE subsystem
+			Format: ide-core.options="ide=nodma hdd=cdrom idebus=..."
 			See Documentation/ide.txt.
 
 	idle=		[X86]
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index ab9ca2b..28923ef 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1654,6 +1654,25 @@ struct bus_type ide_bus_type = {
 
 EXPORT_SYMBOL_GPL(ide_bus_type);
 
+static char *options;
+module_param(options, charp, S_IRUGO);
+MODULE_LICENSE("GPL");
+
+static void __init parse_options(char *line)
+{
+	char *next = line;
+
+	if (line == NULL || !*line)
+		return;
+	while ((line = next) != NULL) {
+		next = strchr(line, ' ');
+		if (next != NULL)
+			*next++ = 0;
+		if (!ide_setup(line))
+			printk(KERN_INFO "Unknown option '%s'\n", line);
+	}
+}
+
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
@@ -1661,6 +1680,8 @@ static int __init ide_init(void)
 {
 	int ret;
 
+	parse_options(options);
+
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
 	system_bus_speed = ide_system_bus_speed();
 
@@ -1681,32 +1702,7 @@ static int __init ide_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-static char *options = NULL;
-module_param(options, charp, 0);
-MODULE_LICENSE("GPL");
-
-static void __init parse_options (char *line)
-{
-	char *next = line;
-
-	if (line == NULL || !*line)
-		return;
-	while ((line = next) != NULL) {
- 		if ((next = strchr(line,' ')) != NULL)
-			*next++ = 0;
-		if (!ide_setup(line))
-			printk (KERN_INFO "Unknown option '%s'\n", line);
-	}
-}
-
-int __init init_module (void)
-{
-	parse_options(options);
-	return ide_init();
-}
-
-void __exit cleanup_module (void)
+static void __exit ide_exit(void)
 {
 	int index;
 
@@ -1718,10 +1714,5 @@ void __exit cleanup_module (void)
 	bus_unregister(&ide_bus_type);
 }
 
-#else /* !MODULE */
-
-__setup("", ide_setup);
-
 module_init(ide_init);
-
-#endif /* MODULE */
+module_exit(ide_exit);
-- 
1.5.3.8

