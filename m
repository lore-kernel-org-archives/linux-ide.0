From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/15] ide: include <asm/ide.h> only when needed
Date: Sun, 01 Feb 2009 18:49:16 +0100
Message-ID: <20090201174916.19144.11318.sendpatchset@localhost.localdomain>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:60140 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbZBARsY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:48:24 -0500
In-Reply-To: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: include <asm/ide.h> only when needed

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io-std.c |    7 +++++++
 drivers/ide/tx4938ide.c  |    2 ++
 drivers/ide/tx4939ide.c  |    2 ++
 include/linux/ide.h      |    7 -------
 4 files changed, 11 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-io-std.c
===================================================================
--- a/drivers/ide/ide-io-std.c
+++ b/drivers/ide/ide-io-std.c
@@ -2,6 +2,13 @@
 #include <linux/kernel.h>
 #include <linux/ide.h>
 
+#if defined(CONFIG_ARM) || defined(CONFIG_M68K) || defined(CONFIG_MIPS) || \
+    defined(CONFIG_PARISC) || defined(CONFIG_PPC) || defined(CONFIG_SPARC)
+#include <asm/ide.h>
+#else
+#include <asm-generic/ide_iops.h>
+#endif
+
 /*
  *	Conventional PIO operations for ATA devices
  */
Index: b/drivers/ide/tx4938ide.c
===================================================================
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -15,6 +15,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+
+#include <asm/ide.h>
 #include <asm/txx9/tx4938.h>
 
 static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
Index: b/drivers/ide/tx4939ide.c
===================================================================
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -18,6 +18,8 @@
 #include <linux/io.h>
 #include <linux/scatterlist.h>
 
+#include <asm/ide.h>
+
 #define MODNAME	"tx4939ide"
 
 /* ATA Shadow Registers (8-bit except for Data which is 16-bit) */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -193,13 +193,6 @@ static inline void ide_std_init_ports(hw
 	hw->io_ports.ctl_addr = ctl_addr;
 }
 
-#if defined(CONFIG_ARM) || defined(CONFIG_M68K) || defined(CONFIG_MIPS) || \
-    defined(CONFIG_PARISC) || defined(CONFIG_PPC) || defined(CONFIG_SPARC)
-#include <asm/ide.h>
-#else
-#include <asm-generic/ide_iops.h>
-#endif
-
 #define MAX_HWIFS	10
 
 /*
