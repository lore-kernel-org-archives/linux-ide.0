From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] remove unnecessary <linux/hdreg.h> includes
Date: Sun, 27 Jul 2008 17:31:33 +0200
Message-ID: <200807271731.33332.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:25123 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbYG0PfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jul 2008 11:35:06 -0400
Received: by mu-out-0910.google.com with SMTP id w8so4455932mue.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Jul 2008 08:35:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>

Following files don't need <linux/hdreg.h> at all:

- arch/mips/jazz/setup.c
- arch/sh/boards/renesas/systemh/irq.c
- drivers/macintosh/mediabay.c
- drivers/scsi/hptiop.c
- drivers/usb/storage/freecom.c
- include/asm-powerpc/ide.h
- init/main.c

Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/mips/jazz/setup.c               |    1 -
 arch/sh/boards/renesas/systemh/irq.c |    1 -
 drivers/macintosh/mediabay.c         |    1 -
 drivers/scsi/hptiop.c                |    1 -
 drivers/usb/storage/freecom.c        |    2 --
 include/asm-powerpc/ide.h            |    1 -
 init/main.c                          |    1 -
 7 files changed, 8 deletions(-)

Index: b/arch/mips/jazz/setup.c
===================================================================
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2007 by Thomas Bogendoerfer
  */
 #include <linux/eisa.h>
-#include <linux/hdreg.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
Index: b/arch/sh/boards/renesas/systemh/irq.c
===================================================================
--- a/arch/sh/boards/renesas/systemh/irq.c
+++ b/arch/sh/boards/renesas/systemh/irq.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 
-#include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <asm/io.h>
 #include <asm/systemh7751.h>
Index: b/drivers/macintosh/mediabay.c
===================================================================
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
-#include <linux/hdreg.h>
 #include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/ide.h>
Index: b/drivers/scsi/hptiop.c
===================================================================
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/spinlock.h>
-#include <linux/hdreg.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/div64.h>
Index: b/drivers/usb/storage/freecom.c
===================================================================
--- a/drivers/usb/storage/freecom.c
+++ b/drivers/usb/storage/freecom.c
@@ -26,8 +26,6 @@
  * (http://www.freecom.de/)
  */
 
-#include <linux/hdreg.h>
-
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 
Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -20,7 +20,6 @@
 #define __ide_mm_outsl(p, a, c)	writesl((void __iomem *)(p), (a), (c))
 
 #ifndef  __powerpc64__
-#include <linux/hdreg.h>
 #include <linux/ioport.h>
 
 /* FIXME: use ide_platform host driver */
Index: b/init/main.c
===================================================================
--- a/init/main.c
+++ b/init/main.c
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/initrd.h>
-#include <linux/hdreg.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
 #include <linux/gfp.h>
