From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] umc8672.c warning
Date: Thu, 11 Sep 2003 08:27:37 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0309110826250.1879-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.sonytel.be ([195.0.45.172]:47071 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266144AbTIKG1k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Sep 2003 02:27:40 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>


Move dtc2278_release() to kill a warning in the non-modular case

--- linux-2.6.0-test5/drivers/ide/legacy/umc8672.c.orig	Tue Sep  9 10:12:44 2003
+++ linux-2.6.0-test5/drivers/ide/legacy/umc8672.c	Tue Sep  9 14:18:28 2003
@@ -160,6 +160,25 @@
 	return 0;
 }
 
+#ifndef MODULE
+/*
+ * init_umc8672:
+ *
+ * called by ide.c when parsing command line
+ */
+
+void __init init_umc8672 (void)
+{
+	if (probe_umc8672())
+		printk(KERN_ERR "init_umc8672: umc8672 controller not found.\n");
+}
+
+#else
+
+MODULE_AUTHOR("Wolfram Podien");
+MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
+MODULE_LICENSE("GPL");
+
 static void umc8672_release (void)
 {
 	unsigned long flags;
@@ -185,25 +204,6 @@
 	release_region(0x108, 2);
 	local_irq_restore(flags);
 }
-
-#ifndef MODULE
-/*
- * init_umc8672:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_umc8672 (void)
-{
-	if (probe_umc8672())
-		printk(KERN_ERR "init_umc8672: umc8672 controller not found.\n");
-}
-
-#else
-
-MODULE_AUTHOR("Wolfram Podien");
-MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
-MODULE_LICENSE("GPL");
 
 static int __init umc8672_mod_init(void)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

