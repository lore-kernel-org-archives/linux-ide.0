From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] obsolete asm/hdreg.h [5/5]
Date: Thu, 8 Apr 2004 00:24:17 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404080024.17999.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38618 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261210AbUDGWYz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Apr 2004 18:24:55 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org


[IDE] obsolete asm/hdreg.h

 linux-2.6.5-root/include/asm-generic/hdreg.h   |    2 ++
 linux-2.6.5-root/include/asm-h8300/hdreg.h     |    2 ++
 linux-2.6.5-root/include/asm-i386/hdreg.h      |   12 +-----------
 linux-2.6.5-root/include/asm-ia64/hdreg.h      |    2 ++
 linux-2.6.5-root/include/asm-m68k/hdreg.h      |   12 +-----------
 linux-2.6.5-root/include/asm-ppc/ide.h         |    2 --
 linux-2.6.5-root/include/asm-sparc/ide.h       |    1 -
 linux-2.6.5-root/include/asm-sparc64/ide.h     |    1 -
 linux-2.6.5-root/include/asm-v850/rte_me2_cb.h |    2 +-
 linux-2.6.5-root/include/asm-x86_64/hdreg.h    |   11 +----------
 linux-2.6.5-root/include/linux/ide.h           |    1 -
 11 files changed, 10 insertions(+), 38 deletions(-)

diff -puN include/asm-generic/hdreg.h~obsolete_asm_hdreg include/asm-generic/hdreg.h
--- linux-2.6.5/include/asm-generic/hdreg.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-generic/hdreg.h	2004-04-06 02:52:38.000000000 +0200
@@ -1,3 +1,5 @@
+#warning <asm/hdreg.h> is obsolete, please do not use it
+
 #ifndef __ASM_GENERIC_HDREG_H
 #define __ASM_GENERIC_HDREG_H
 
diff -puN include/asm-h8300/hdreg.h~obsolete_asm_hdreg include/asm-h8300/hdreg.h
--- linux-2.6.5/include/asm-h8300/hdreg.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-h8300/hdreg.h	2004-04-06 02:52:38.000000000 +0200
@@ -4,6 +4,8 @@
  *  Copyright (C) 1994-1996  Linus Torvalds & authors
  */
 
+#warning this file is obsolete, please do not use it
+
 #ifndef _H8300_HDREG_H
 #define _H8300_HDREG_H
 
diff -puN include/asm-i386/hdreg.h~obsolete_asm_hdreg include/asm-i386/hdreg.h
--- linux-2.6.5/include/asm-i386/hdreg.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-i386/hdreg.h	2004-04-06 02:52:38.000000000 +0200
@@ -1,11 +1 @@
-/*
- *  linux/include/asm-i386/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASMi386_HDREG_H
-#define __ASMi386_HDREG_H
-
-
-#endif /* __ASMi386_HDREG_H */
+#warning this file is obsolete, please do not use it
diff -puN include/asm-ia64/hdreg.h~obsolete_asm_hdreg include/asm-ia64/hdreg.h
--- linux-2.6.5/include/asm-ia64/hdreg.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-ia64/hdreg.h	2004-04-06 02:52:38.000000000 +0200
@@ -4,6 +4,8 @@
  *  Copyright (C) 1994-1996  Linus Torvalds & authors
  */
 
+#warning this file is obsolete, please do not use it
+
 #ifndef __ASM_IA64_HDREG_H
 #define __ASM_IA64_HDREG_H
 
diff -puN include/asm-m68k/hdreg.h~obsolete_asm_hdreg include/asm-m68k/hdreg.h
--- linux-2.6.5/include/asm-m68k/hdreg.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-m68k/hdreg.h	2004-04-06 02:52:38.000000000 +0200
@@ -1,11 +1 @@
-/*
- *  linux/include/asm-m68k/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef _M68K_HDREG_H
-#define _M68K_HDREG_H
-
-
-#endif /* _M68K_HDREG_H */
+#warning this file is obsolete, please do not use it
diff -puN include/asm-ppc/ide.h~obsolete_asm_hdreg include/asm-ppc/ide.h
--- linux-2.6.5/include/asm-ppc/ide.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-ppc/ide.h	2004-04-06 02:52:38.000000000 +0200
@@ -19,8 +19,6 @@
 #define MAX_HWIFS	8
 #endif
 
-#include <asm/hdreg.h>
-
 #include <linux/config.h>
 #include <linux/hdreg.h>
 #include <linux/ioport.h>
diff -puN include/asm-sparc64/ide.h~obsolete_asm_hdreg include/asm-sparc64/ide.h
--- linux-2.6.5/include/asm-sparc64/ide.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-sparc64/ide.h	2004-04-06 02:52:38.000000000 +0200
@@ -13,7 +13,6 @@
 #include <linux/config.h>
 #include <asm/pgalloc.h>
 #include <asm/io.h>
-#include <asm/hdreg.h>
 #include <asm/page.h>
 #include <asm/spitfire.h>
 
diff -puN include/asm-sparc/ide.h~obsolete_asm_hdreg include/asm-sparc/ide.h
--- linux-2.6.5/include/asm-sparc/ide.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-sparc/ide.h	2004-04-06 02:52:38.000000000 +0200
@@ -14,7 +14,6 @@
 #include <linux/config.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <asm/hdreg.h>
 #include <asm/psr.h>
 
 #undef  MAX_HWIFS
diff -puN include/asm-v850/rte_me2_cb.h~obsolete_asm_hdreg include/asm-v850/rte_me2_cb.h
--- linux-2.6.5/include/asm-v850/rte_me2_cb.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-v850/rte_me2_cb.h	2004-04-06 02:52:38.000000000 +0200
@@ -147,7 +147,7 @@ extern void cb_pic_init_irqs (void);
 #define CB_UART_REG_GAP 	0x10
 #define CB_UART_CLOCK   	0x16000000
 
-/* CompactFlash setting see also asm/ide.h, asm/hdreg.h.  */
+/* CompactFlash setting */
 #define CB_CF_BASE     		0x0FE0C000
 #define CB_CF_CCR_ADDR 		(CB_CF_BASE+0x200)
 #define CB_CF_CCR      		(*(volatile u8 *)CB_CF_CCR_ADDR)
diff -puN include/asm-x86_64/hdreg.h~obsolete_asm_hdreg include/asm-x86_64/hdreg.h
--- linux-2.6.5/include/asm-x86_64/hdreg.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/asm-x86_64/hdreg.h	2004-04-06 02:52:38.000000000 +0200
@@ -1,10 +1 @@
-/*
- *  linux/include/asm-x86_64/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASMx86_64_HDREG_H
-#define __ASMx86_64_HDREG_H
-
-#endif /* __ASMx86_64_HDREG_H */
+#warning this file is obsolete, please do not use it
diff -puN include/linux/ide.h~obsolete_asm_hdreg include/linux/ide.h
--- linux-2.6.5/include/linux/ide.h~obsolete_asm_hdreg	2004-04-06 02:52:38.000000000 +0200
+++ linux-2.6.5-root/include/linux/ide.h	2004-04-06 02:52:38.000000000 +0200
@@ -20,7 +20,6 @@
 #include <linux/pci.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
-#include <asm/hdreg.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 

_

