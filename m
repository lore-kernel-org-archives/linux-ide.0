From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] IDE: move CONFIG_IDE_MAX_HWIFS into linux/ide.h
Date: Fri, 16 Sep 2005 11:33:10 -0600
Message-ID: <200509161133.10493.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:2744 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030587AbVIPRdh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2005 13:33:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, linux-sh@m17n.org

CONFIG_IDE_MAX_HWIFS is a generic thing, no need to have it duplicated
by every arch that uses it.

Previous posts elicited no responses:
    http://www.uwsg.iu.edu/hypermail/linux/kernel/0508.3/0111.html
    http://www.uwsg.iu.edu/hypermail/linux/kernel/0508.3/1299.html

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-ide/include/asm-alpha/ide.h
===================================================================
--- work-ide.orig/include/asm-alpha/ide.h	2005-08-24 09:36:41.000000000 -0600
+++ work-ide/include/asm-alpha/ide.h	2005-08-24 09:37:12.000000000 -0600
@@ -15,10 +15,6 @@
 
 #include <linux/config.h>
 
-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
 static inline int ide_default_irq(unsigned long base)
Index: work-ide/include/asm-sh/ide.h
===================================================================
--- work-ide.orig/include/asm-sh/ide.h	2005-08-24 09:36:41.000000000 -0600
+++ work-ide/include/asm-sh/ide.h	2005-08-24 09:37:12.000000000 -0600
@@ -16,10 +16,6 @@
 
 #include <linux/config.h>
 
-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
 #define ide_default_io_ctl(base)	(0)
 
 #include <asm-generic/ide_iops.h>
Index: work-ide/include/asm-sh64/ide.h
===================================================================
--- work-ide.orig/include/asm-sh64/ide.h	2005-08-24 09:36:41.000000000 -0600
+++ work-ide/include/asm-sh64/ide.h	2005-08-24 09:37:12.000000000 -0600
@@ -17,10 +17,6 @@
 
 #include <linux/config.h>
 
-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
 /* Without this, the initialisation of PCI IDE cards end up calling
  * ide_init_hwif_ports, which won't work. */
 #ifdef CONFIG_BLK_DEV_IDEPCI
Index: work-ide/include/linux/ide.h
===================================================================
--- work-ide.orig/include/linux/ide.h	2005-08-24 09:37:03.000000000 -0600
+++ work-ide/include/linux/ide.h	2005-08-24 09:37:24.000000000 -0600
@@ -266,6 +266,10 @@
 
 #include <asm/ide.h>
 
+#ifndef MAX_HWIFS
+#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
+#endif
+
 /* needed on alpha, x86/x86_64, ia64, mips, ppc32 and sh */
 #ifndef IDE_ARCH_OBSOLETE_DEFAULTS
 # define ide_default_io_base(index)	(0)

