From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/10] ide: remove <asm-cris/ide.h>
Date: Mon, 7 Jul 2008 23:53:09 +0200
Message-ID: <200807072353.09634.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:9493 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758630AbYGGWBE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:01:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1051981ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jesper Nilsson <Jesper.Nilsson@axis.com>, Mikael Starvik <mikael.starvik@axis.com>

Remove <asm-cris/arch-v{10,32}/ide.h> and <asm-cris/ide.h>.

This has been a broken code for some time now and needs rewrite
to match IDE core code / host driver model anyway.

Cc: Jesper Nilsson <Jesper.Nilsson@axis.com>
Cc: Mikael Starvik <mikael.starvik@axis.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-cris/arch-v10/ide.h |   91 ----------------------------------------
 include/asm-cris/arch-v32/ide.h |   56 ------------------------
 include/asm-cris/ide.h          |    1 
 3 files changed, 148 deletions(-)

Index: b/include/asm-cris/arch-v10/ide.h
===================================================================
--- a/include/asm-cris/arch-v10/ide.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- *  linux/include/asm-cris/ide.h
- *
- *  Copyright (C) 2000, 2001, 2002  Axis Communications AB
- *
- *  Authors:    Bjorn Wesen
- *
- */
-
-/*
- *  This file contains the ETRAX 100LX specific IDE code.
- */
-
-#ifndef __ASMCRIS_IDE_H
-#define __ASMCRIS_IDE_H
-
-#ifdef __KERNEL__
-
-#include <asm/arch/svinto.h>
-#include <asm/io.h>
-#include <asm-generic/ide_iops.h>
-
-
-/* ETRAX 100 can support 4 IDE busses on the same pins (serialized) */
-
-#define MAX_HWIFS	4
-
-static inline int ide_default_irq(unsigned long base)
-{
-	/* all IDE busses share the same IRQ, number 4.
-	 * this has the side-effect that ide-probe.c will cluster our 4 interfaces
-	 * together in a hwgroup, and will serialize accesses. this is good, because
-	 * we can't access more than one interface at the same time on ETRAX100.
-	 */
-	return 4;
-}
-
-static inline unsigned long ide_default_io_base(int index)
-{
-	/* we have no real I/O base address per interface, since all go through the
-	 * same register. but in a bitfield in that register, we have the i/f number.
-	 * so we can use the io_base to remember that bitfield.
-	 */
-	static const unsigned long io_bases[MAX_HWIFS] = {
-		IO_FIELD(R_ATA_CTRL_DATA, sel, 0),
-		IO_FIELD(R_ATA_CTRL_DATA, sel, 1),
-		IO_FIELD(R_ATA_CTRL_DATA, sel, 2),
-		IO_FIELD(R_ATA_CTRL_DATA, sel, 3)
-	};
-	return io_bases[index];
-}
-
-/* this is called once for each interface, to setup the port addresses. data_port is the result
- * of the ide_default_io_base call above. ctrl_port will be 0, but that is don't care for us.
- */
-
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port, unsigned long ctrl_port, int *irq)
-{
-	int i;
-
-	/* fill in ports for ATA addresses 0 to 7 */
-	for (i = 0; i <= 7; i++) {
-		hw->io_ports_array[i] = data_port |
-			IO_FIELD(R_ATA_CTRL_DATA, addr, i) |
-			IO_STATE(R_ATA_CTRL_DATA, cs0, active);
-	}
-
-	/* the IDE control register is at ATA address 6, with CS1 active instead of CS0 */
-	hw->io_ports.ctl_addr = data_port |
-			IO_FIELD(R_ATA_CTRL_DATA, addr, 6) |
-			IO_STATE(R_ATA_CTRL_DATA, cs1, active);
-
-	/* whats this for ? */
-	hw->io_ports.irq_addr = 0;
-}
-
-static inline void ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASMCRIS_IDE_H */
Index: b/include/asm-cris/arch-v32/ide.h
===================================================================
--- a/include/asm-cris/arch-v32/ide.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *  linux/include/asm-cris/ide.h
- *
- *  Copyright (C) 2000-2004  Axis Communications AB
- *
- *  Authors:    Bjorn Wesen, Mikael Starvik
- *
- */
-
-/*
- *  This file contains the ETRAX FS specific IDE code.
- */
-
-#ifndef __ASMCRIS_IDE_H
-#define __ASMCRIS_IDE_H
-
-#ifdef __KERNEL__
-
-#include <asm/arch/hwregs/intr_vect.h>
-#include <asm/arch/hwregs/ata_defs.h>
-#include <asm/io.h>
-#include <asm-generic/ide_iops.h>
-
-
-/* ETRAX FS can support 4 IDE busses on the same pins (serialized) */
-
-#define MAX_HWIFS	4
-
-static inline int ide_default_irq(unsigned long base)
-{
-	/* all IDE busses share the same IRQ,
-	 * this has the side-effect that ide-probe.c will cluster our 4 interfaces
-	 * together in a hwgroup, and will serialize accesses. this is good, because
-	 * we can't access more than one interface at the same time on ETRAX100.
-	 */
-	return ATA_INTR_VECT;
-}
-
-static inline unsigned long ide_default_io_base(int index)
-{
-	reg_ata_rw_ctrl2 ctrl2 = {.sel = index};
-	/* we have no real I/O base address per interface, since all go through the
-	 * same register. but in a bitfield in that register, we have the i/f number.
-	 * so we can use the io_base to remember that bitfield.
-	 */
-        ctrl2.sel = index;
-
-	return REG_TYPE_CONV(unsigned long, reg_ata_rw_ctrl2, ctrl2);
-}
-
-#define IDE_ARCH_ACK_INTR
-#define ide_ack_intr(hwif)	((hwif)->ack_intr(hwif))
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASMCRIS_IDE_H */
Index: b/include/asm-cris/ide.h
===================================================================
--- a/include/asm-cris/ide.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/arch/ide.h>
