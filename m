From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/4] m68k: cleanup <asm/ide.h>
Date: Tue, 27 Jan 2009 19:03:13 +0100
Message-ID: <20090127180313.28089.37099.sendpatchset@localhost.localdomain>
References: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:43649 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbZA0SCx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 13:02:53 -0500
In-Reply-To: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-m68k@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: cleanup <asm-m68k/ide.h>

* Remove superfluous <asm/macints.h> include.

* No need to re-define in/out*() macros as they are no longer used
  by m68k host drivers.

* readl() and writel() are not used by core IDE code.

* Use raw_*_swapw() directly in {falcon,q40}ide.c and remove
  {in,out}sw_swapw() macros.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/falconide.c |    4 ++--
 drivers/ide/q40ide.c    |    4 ++--
 include/asm-m68k/ide.h  |   34 ----------------------------------
 3 files changed, 4 insertions(+), 38 deletions(-)

Index: b/drivers/ide/falconide.c
===================================================================
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -70,7 +70,7 @@ static void falconide_input_data(ide_dri
 	if (drive->media == ide_disk && rq && rq->cmd_type == REQ_TYPE_FS)
 		return insw(data_addr, buf, (len + 1) / 2);
 
-	insw_swapw(data_addr, buf, (len + 1) / 2);
+	raw_insw_swapw((u16 *)data_addr, buf, (len + 1) / 2);
 }
 
 static void falconide_output_data(ide_drive_t *drive, struct request *rq,
@@ -81,7 +81,7 @@ static void falconide_output_data(ide_dr
 	if (drive->media == ide_disk && rq && rq->cmd_type == REQ_TYPE_FS)
 		return outsw(data_addr, buf, (len + 1) / 2);
 
-	outsw_swapw(data_addr, buf, (len + 1) / 2);
+	raw_outsw_swapw((u16 *)data_addr, buf, (len + 1) / 2);
 }
 
 /* Atari has a byte-swapped IDE interface */
Index: b/drivers/ide/q40ide.c
===================================================================
--- a/drivers/ide/q40ide.c
+++ b/drivers/ide/q40ide.c
@@ -80,7 +80,7 @@ static void q40ide_input_data(ide_drive_
 	if (drive->media == ide_disk && rq && rq->cmd_type == REQ_TYPE_FS)
 		return insw(data_addr, buf, (len + 1) / 2);
 
-	insw_swapw(data_addr, buf, (len + 1) / 2);
+	raw_insw_swapw((u16 *)data_addr, buf, (len + 1) / 2);
 }
 
 static void q40ide_output_data(ide_drive_t *drive, struct request *rq,
@@ -91,7 +91,7 @@ static void q40ide_output_data(ide_drive
 	if (drive->media == ide_disk && rq && rq->cmd_type == REQ_TYPE_FS)
 		return outsw(data_addr, buf, (len + 1) / 2);
 
-	outsw_swapw(data_addr, buf, (len + 1) / 2);
+	raw_outsw_swapw((u16 *)data_addr, buf, (len + 1) / 2);
 }
 
 /* Q40 has a byte-swapped IDE interface */
Index: b/include/asm-m68k/ide.h
===================================================================
--- a/include/asm-m68k/ide.h
+++ b/include/asm-m68k/ide.h
@@ -30,62 +30,28 @@
 #define _M68K_IDE_H
 
 #ifdef __KERNEL__
-
-
 #include <asm/setup.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#ifdef CONFIG_MAC
-#include <asm/macints.h>
-#endif
-
 /*
  * Get rid of defs from io.h - ide has its private and conflicting versions
  * Since so far no single m68k platform uses ISA/PCI I/O space for IDE, we
  * always use the `raw' MMIO versions
  */
-#undef inb
-#undef inw
-#undef insw
-#undef inl
-#undef insl
-#undef outb
-#undef outw
-#undef outsw
-#undef outl
-#undef outsl
 #undef readb
 #undef readw
-#undef readl
 #undef writeb
 #undef writew
-#undef writel
 
-#define inb				in_8
-#define inw				in_be16
-#define insw(port, addr, n)		raw_insw((u16 *)port, addr, n)
-#define inl				in_be32
-#define insl(port, addr, n)		raw_insl((u32 *)port, addr, n)
-#define outb(val, port)			out_8(port, val)
-#define outw(val, port)			out_be16(port, val)
-#define outsw(port, addr, n)		raw_outsw((u16 *)port, addr, n)
-#define outl(val, port)			out_be32(port, val)
-#define outsl(port, addr, n)		raw_outsl((u32 *)port, addr, n)
 #define readb				in_8
 #define readw				in_be16
 #define __ide_mm_insw(port, addr, n)	raw_insw((u16 *)port, addr, n)
-#define readl				in_be32
 #define __ide_mm_insl(port, addr, n)	raw_insl((u32 *)port, addr, n)
 #define writeb(val, port)		out_8(port, val)
 #define writew(val, port)		out_be16(port, val)
 #define __ide_mm_outsw(port, addr, n)	raw_outsw((u16 *)port, addr, n)
-#define writel(val, port)		out_be32(port, val)
 #define __ide_mm_outsl(port, addr, n)	raw_outsl((u32 *)port, addr, n)
-#if defined(CONFIG_ATARI) || defined(CONFIG_Q40)
-#define insw_swapw(port, addr, n)	raw_insw_swapw((u16 *)port, addr, n)
-#define outsw_swapw(port, addr, n)	raw_outsw_swapw((u16 *)port, addr, n)
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* _M68K_IDE_H */
