From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove dead <asm-arm/arch-sa1100/ide.h>
Date: Sun, 10 Aug 2008 17:45:20 +0200
Message-ID: <200808101745.20434.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:3529 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbYHJPtu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:49:50 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3064624mue.1
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:49:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

It has been dead for more than 3 years and needs to be converted
to use platform PATA support anyway.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-arm/arch-sa1100/ide.h |   75 --------------------------------------
 1 file changed, 75 deletions(-)

Index: b/include/asm-arm/arch-sa1100/ide.h
===================================================================
--- a/include/asm-arm/arch-sa1100/ide.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * linux/include/asm-arm/arch-sa1100/ide.h
- *
- * Copyright (c) 1998 Hugo Fiennes & Nicolas Pitre
- *
- * 18-aug-2000: Cleanup by Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
- *              Get rid of the special ide_init_hwif_ports() functions
- *              and make a generalised function that can be used by all
- *              architectures.
- */
-
-#include <asm/irq.h>
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
-
-#error "This code is broken and needs update to match with current ide support"
-
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-	int regincr = 1;
-
-	/* The Empeg board has the first two address lines unused */
-	if (machine_is_empeg())
-		regincr = 1 << 2;
-
-	/* The LART doesn't use A0 for IDE */
-	if (machine_is_lart())
-		regincr = 1 << 1;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = 0; i <= 7; i++) {
-		hw->io_ports_array[i] = reg;
-		reg += regincr;
-	}
-
-	hw->io_ports.ctl_addr = ctrl_port;
-
-	if (irq)
-		*irq = 0;
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-    if (machine_is_lart()) {
-#ifdef CONFIG_SA1100_LART
-        hw_regs_t hw;
-
-        /* Enable GPIO as interrupt line */
-        GPDR &= ~LART_GPIO_IDE;
-	set_irq_type(LART_IRQ_IDE, IRQ_TYPE_EDGE_RISING);
-
-        /* set PCMCIA interface timing */
-        MECR = 0x00060006;
-
-        /* init the interface */
-	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x0000, PCMCIA_IO_0_BASE + 0x1000, NULL);
-        hw.irq = LART_IRQ_IDE;
-        ide_register_hw(&hw);
-#endif
-    }
-}
