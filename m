From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dtc2278.c warning
Date: Thu, 11 Sep 2003 08:26:21 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0309110824070.1879-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Move dtc2278_release() to kill a warning in the non-modular case

--- linux-2.6.0-test5/drivers/ide/legacy/dtc2278.c.orig	Tue Sep  9 10:12:44 2003
+++ linux-2.6.0-test5/drivers/ide/legacy/dtc2278.c	Tue Sep  9 14:15:35 2003
@@ -134,6 +134,24 @@
 	probe_hwif_init(&ide_hwifs[1]);
 }
 
+#ifndef MODULE
+/*
+ * init_dtc2278:
+ *
+ * called by ide.c when parsing command line
+ */
+
+void __init init_dtc2278 (void)
+{
+	probe_dtc2278();
+}
+
+#else
+
+MODULE_AUTHOR("See Local File");
+MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
+MODULE_LICENSE("GPL");
+
 static void dtc2278_release (void)
 {
 	if (ide_hwifs[0].chipset != ide_dtc2278 &&
@@ -152,24 +170,6 @@
 	ide_hwifs[0].mate = NULL;
 	ide_hwifs[1].mate = NULL;
 }
-
-#ifndef MODULE
-/*
- * init_dtc2278:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_dtc2278 (void)
-{
-	probe_dtc2278();
-}
-
-#else
-
-MODULE_AUTHOR("See Local File");
-MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
-MODULE_LICENSE("GPL");
 
 static int __init dtc2278_mod_init(void)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
