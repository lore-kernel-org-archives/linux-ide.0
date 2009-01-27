From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] ide: make m68k host drivers use IDE_HFLAG_MMIO
Date: Tue, 27 Jan 2009 19:03:06 +0100
Message-ID: <20090127180306.28089.67543.sendpatchset@localhost.localdomain>
References: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: make m68k host drivers use IDE_HFLAG_MMIO

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/buddha.c    |    6 +-----
 drivers/ide/falconide.c |    3 ++-
 drivers/ide/gayle.c     |    6 ++----
 drivers/ide/macide.c    |    2 +-
 drivers/ide/q40ide.c    |    2 +-
 5 files changed, 7 insertions(+), 12 deletions(-)

Index: b/drivers/ide/buddha.c
===================================================================
--- a/drivers/ide/buddha.c
+++ b/drivers/ide/buddha.c
@@ -144,7 +144,7 @@ static void __init buddha_setup_ports(hw
 }
 
 static const struct ide_port_info buddha_port_info = {
-	.host_flags		= IDE_HFLAG_NO_DMA,
+	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
 };
 
     /*
@@ -176,10 +176,6 @@ static int __init buddha_init(void)
 		
 		board = z->resource.start;
 
-/*
- * FIXME: we now have selectable mmio v/s iomio transports.
- */
-
 		if(type != BOARD_XSURF) {
 			if (!request_mem_region(board+BUDDHA_BASE1, 0x800, "IDE"))
 				continue;
Index: b/drivers/ide/falconide.c
===================================================================
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -103,7 +103,8 @@ static const struct ide_port_info falcon
 	.get_lock		= falconide_get_lock,
 	.release_lock		= falconide_release_lock,
 	.tp_ops			= &falconide_tp_ops,
-	.host_flags		= IDE_HFLAG_NO_DMA | IDE_HFLAG_SERIALIZE,
+	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_SERIALIZE |
+				  IDE_HFLAG_NO_DMA,
 };
 
 static void __init falconide_setup_ports(hw_regs_t *hw)
Index: b/drivers/ide/gayle.c
===================================================================
--- a/drivers/ide/gayle.c
+++ b/drivers/ide/gayle.c
@@ -118,7 +118,8 @@ static void __init gayle_setup_ports(hw_
 }
 
 static const struct ide_port_info gayle_port_info = {
-	.host_flags		= IDE_HFLAG_SERIALIZE | IDE_HFLAG_NO_DMA,
+	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_SERIALIZE |
+				  IDE_HFLAG_NO_DMA,
 };
 
     /*
@@ -163,9 +164,6 @@ found:
 	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_1200);
 	    ack_intr = gayle_ack_intr_a1200;
 	}
-/*
- * FIXME: we now have selectable modes between mmio v/s iomio
- */
 
 	res_start = ((unsigned long)phys_base) & ~(GAYLE_NEXT_PORT-1);
 	res_n = GAYLE_IDEREG_SIZE;
Index: b/drivers/ide/macide.c
===================================================================
--- a/drivers/ide/macide.c
+++ b/drivers/ide/macide.c
@@ -81,7 +81,7 @@ static void __init macide_setup_ports(hw
 }
 
 static const struct ide_port_info macide_port_info = {
-	.host_flags		= IDE_HFLAG_NO_DMA,
+	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
 };
 
 static const char *mac_ide_name[] =
Index: b/drivers/ide/q40ide.c
===================================================================
--- a/drivers/ide/q40ide.c
+++ b/drivers/ide/q40ide.c
@@ -111,7 +111,7 @@ static const struct ide_tp_ops q40ide_tp
 
 static const struct ide_port_info q40ide_port_info = {
 	.tp_ops			= &q40ide_tp_ops,
-	.host_flags		= IDE_HFLAG_NO_DMA,
+	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
 };
 
 /* 
