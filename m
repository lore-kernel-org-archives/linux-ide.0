From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ARM{26} IDE cleanups
Date: Tue, 20 Apr 2004 23:35:59 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404202335.59291.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49571 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264572AbUDTVmu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Apr 2004 17:42:50 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org


Hi,

This patch is incremental to the
"sanitize ARM26 A5K and ARM CLPS7500/RPC/Shark IDE support" patch.

I tried to fix SA1100 IDE support but I failed. :-)

It seems it is broken since 2.5.16 when PCMCIA_IO_0_BASE define
was removed from <asm-arm/arch-sa1100/hardware.h>.

Cheers,
Bartlomiej

[PATCH] ARM{26} IDE cleanups

- Fix arch/arm/Kconfig to allow IDE only on platforms supporting it.

- Remove no longer needed ide_init_default_hwifs() call from ide.c.

- Use generic ide_init_hwif_ports() on ARM26 and ARM.  Some platforms were
  clearing hw in ide_init_hwif_ports() - it makes sense only in setup-pci.c
  as all other users that can be build on ARM clear hw themselves.

- Kill <asm-arm/arch-*/ide.h> (except broken <asm-arm/arch-sa1100/ide.h>).

Cross-compile tested on non-broken ARM platforms.

 linux-2.6.6-rc1-bk5-bzolnier/arch/arm/Kconfig           |    2 
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/ide.c          |    8 --
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/setup-pci.c    |   10 +-
 linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/ide.h      |    2 
 linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm26/ide.h    |   21 ------
 linux-2.6.6-rc1-bk5-bzolnier/include/linux/ide.h        |   12 ++-
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-cl7500/ide.h   |   36 ----------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-ebsa110/ide.h  |    1 
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-ebsa285/ide.h  |   49 --------------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-iop3xx/ide.h   |   49 --------------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-l7200/ide.h    |   27 --------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-nexuspci/ide.h |   37 ----------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-pxa/ide.h      |   54 ----------------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-rpc/ide.h      |   35 ----------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-s3c2410/ide.h  |   49 --------------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-shark/ide.h    |   32 ---------
 linux-2.6.6-rc1-bk5/include/asm-arm/arch-tbox/ide.h     |    3 
 17 files changed, 16 insertions(+), 411 deletions(-)

diff -puN arch/arm/Kconfig~arm_arch_ide arch/arm/Kconfig
--- linux-2.6.6-rc1-bk5/arch/arm/Kconfig~arm_arch_ide	2004-04-20 22:13:56.374556216 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/arch/arm/Kconfig	2004-04-20 22:13:56.461542992 +0200
@@ -584,7 +584,9 @@ source "drivers/acorn/block/Kconfig"
 
 source "net/Kconfig"
 
+if ARCH_CLPS7500 || FOOTBRIDGE || ARCH_IOP3XX || ARCH_L7200 || ARCH_FTVPCI || ARCH_PXA || ARCH_RPC || ARCH_S3C2410 || ARCH_SA1100 || ARCH_SHARK
 source "drivers/ide/Kconfig"
+endif
 
 source "drivers/scsi/Kconfig"
 
diff -puN drivers/ide/ide.c~arm_arch_ide drivers/ide/ide.c
--- linux-2.6.6-rc1-bk5/drivers/ide/ide.c~arm_arch_ide	2004-04-20 22:13:56.378555608 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/ide.c	2004-04-20 22:13:56.463542688 +0200
@@ -310,14 +310,6 @@ static void __init init_ide_data (void)
 		hwif->irq = hwif->hw.irq =
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
 	}
-
-/* OBSOLETE: still needed on arm26 and arm */
-#ifdef CONFIG_ARM
-	/* Add default hw interfaces */
-	initializing = 1;
-	ide_init_default_hwifs();
-	initializing = 0;
-#endif
 }
 
 /*
diff -puN drivers/ide/setup-pci.c~arm_arch_ide drivers/ide/setup-pci.c
--- linux-2.6.6-rc1-bk5/drivers/ide/setup-pci.c~arm_arch_ide	2004-04-20 22:13:56.384554696 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/setup-pci.c	2004-04-20 22:13:56.465542384 +0200
@@ -444,13 +444,15 @@ static ide_hwif_t *ide_hwif_configure(st
 	}
 	if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL)
 		return NULL;	/* no room in ide_hwifs[] */
-	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
-fixup_address:
+	if (hwif->io_ports[IDE_DATA_OFFSET] != base ||
+	    hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
+/* It's a good idea to always clear hw but play safe for now. */
+#if defined(CONFIG_ARM) && !defined(CONFIG_ARCH_FTVPCI)
+		memset(&hwif->hw, 0, sizeof(hwif->hw));
+#endif
 		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-	} else if (hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
-		goto fixup_address;
 	}
 	hwif->chipset = ide_pci;
 	hwif->pci_dev = dev;
diff -puN include/asm-arm26/ide.h~arm_arch_ide include/asm-arm26/ide.h
--- linux-2.6.6-rc1-bk5/include/asm-arm26/ide.h~arm_arch_ide	2004-04-20 22:13:56.387554240 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm26/ide.h	2004-04-20 22:13:56.466542232 +0200
@@ -26,29 +26,8 @@
 #define __ide_mm_outsw(port,addr,len)   writesw(port,addr,len)
 #define __ide_mm_outsl(port,addr,len)   writesl(port,addr,len)
 
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-        int i;
-
-        for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-                hw->io_ports[i] = reg;
-                reg += 1;
-        }
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-        if (irq)
-                *irq = 0;
-}
-
 #define ide_init_default_irq(base)	(0)
 
-static inline void ide_init_default_hwifs(void) { ; }
-
 /*
  * We always use the new IDE port registering,
  * so these are fixed here.
diff -puN -L include/asm-arm/arch-cl7500/ide.h include/asm-arm/arch-cl7500/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-cl7500/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,36 +0,0 @@
-/*
- * linux/include/asm-arm/arch-cl7500/ide.h
- *
- * Copyright (c) 1997 Russell King
- *
- * Modifications:
- *  29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
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
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = data_port + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static inline void ide_init_default_hwifs(void) { ; }
diff -puN -L include/asm-arm/arch-ebsa110/ide.h include/asm-arm/arch-ebsa110/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-ebsa110/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1 +0,0 @@
-/* no ide */
diff -puN -L include/asm-arm/arch-ebsa285/ide.h include/asm-arm/arch-ebsa285/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-ebsa285/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,49 +0,0 @@
-/*
- *  linux/include/asm-arm/arch-ebsa285/ide.h
- *
- *  Copyright (C) 1998 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Modifications:
- *   29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
-#include <asm/irq.h>
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
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-#if 0
-	hw_regs_t hw;
-
-	memset(hw, 0, sizeof(*hw));
-
-	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-	hw.irq = IRQ_HARDDISK;
-	ide_register_hw(&hw);
-#endif
-}
diff -puN -L include/asm-arm/arch-iop3xx/ide.h include/asm-arm/arch-iop3xx/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-iop3xx/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,49 +0,0 @@
-/*
- * include/asm-arm/arch-iop3xx/ide.h
- *
- * Generic IDE functions for IOP310 systems
- *
- * Author: Deepak Saxena <dsaxena@mvista.com>
- *
- * Copyright 2001 MontaVista Software Inc.
- *
- * 09/26/2001 - Sharon Baartmans
- * 	Fixed so it actually works.
- */
-
-#ifndef _ASM_ARCH_IDE_H_
-#define _ASM_ARCH_IDE_H_
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
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += regincr;
-	}
-
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-
-	if (irq) *irq = 0;
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-	/* There are no standard ports */
-}
-
-#endif
diff -puN -L include/asm-arm/arch-l7200/ide.h include/asm-arm/arch-l7200/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-l7200/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,27 +0,0 @@
-/*
- * linux/include/asm-arm/arch-l7200/ide.h
- *
- * Copyright (c) 2000 Steve Hill (sjhill@cotw.com)
- *
- * Changelog:
- *  03-29-2000	SJH	Created file placeholder
- */
-#include <asm/irq.h>
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-}
diff -puN -L include/asm-arm/arch-nexuspci/ide.h include/asm-arm/arch-nexuspci/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-nexuspci/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,37 +0,0 @@
-/*
- * linux/include/asm-arm/arch-nexuspci/ide.h
- *
- * Copyright (c) 1998 Russell King
- *
- * Modifications:
- *  29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
-#include <asm/irq.h>
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
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-	/* There are no standard ports */
-}
diff -puN -L include/asm-arm/arch-pxa/ide.h include/asm-arm/arch-pxa/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-pxa/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,54 +0,0 @@
-/*
- * linux/include/asm-arm/arch-pxa/ide.h
- *
- * Author:	George Davis
- * Created:	Jan 10, 2002
- * Copyright:	MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *
- * Originally based upon linux/include/asm-arm/arch-sa1100/ide.h
- *
- */
-
-#include <asm/irq.h>
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
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
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += regincr;
-	}
-
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-
-	if (irq)
-		*irq = 0;
-}
-
-
-/*
- * Register the standard ports for this architecture with the IDE driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	/* Nothing to declare... */
-}
diff -puN -L include/asm-arm/arch-rpc/ide.h include/asm-arm/arch-rpc/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-rpc/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,35 +0,0 @@
-/*
- *  linux/include/asm-arm/arch-rpc/ide.h
- *
- *  Copyright (C) 1997 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Modifications:
- *   29-07-1998	RMK	Major re-work of IDE architecture specific code
- */
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
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-static inline void ide_init_default_hwifs(void) { ; }
diff -puN -L include/asm-arm/arch-s3c2410/ide.h include/asm-arm/arch-s3c2410/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-s3c2410/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,49 +0,0 @@
-/* linux/include/asm-arm/arch-s3c2410/ide.h
- *
- *  Copyright (C) 1997 Russell King
- *  Copyright (C) 2003 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Modifications:
- *   29-07-1998	RMK	Major re-work of IDE architecture specific code
- *   16-05-2003 BJD	Changed to work with BAST IDE ports
- *   04-09-2003 BJD	Modifications for V2.6
- */
-
-#ifndef __ASM_ARCH_IDE_H
-#define __ASM_ARCH_IDE_H
-
-#include <asm/irq.h>
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-
-static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
-				       unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-/* we initialise our ide devices from the main ide core, due to problems
- * with doing it in this function
-*/
-
-#define ide_init_default_hwifs() do { } while(0)
-
-#endif /* __ASM_ARCH_IDE_H */
diff -puN -L include/asm-arm/arch-shark/ide.h include/asm-arm/arch-shark/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-shark/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,32 +0,0 @@
-/*
- * linux/include/asm-arm/arch-shark/ide.h
- *
- * by Alexander Schulz
- *
- * derived from:
- * linux/include/asm-arm/arch-ebsa285/ide.h
- * Copyright (c) 1998 Russell King
- */
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
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	if (irq)
-		*irq = 0;
-}
-
-static inline void ide_init_default_hwifs(void) { ; }
diff -puN -L include/asm-arm/arch-tbox/ide.h include/asm-arm/arch-tbox/ide.h~arm_arch_ide /dev/null
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-tbox/ide.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,3 +0,0 @@
-/*
- * linux/include/asm-arm/arch-tbox/ide.h
- */
diff -puN include/asm-arm/ide.h~arm_arch_ide include/asm-arm/ide.h
--- linux-2.6.6-rc1-bk5/include/asm-arm/ide.h~arm_arch_ide	2004-04-20 22:13:56.451544512 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/ide.h	2004-04-20 22:13:56.476540712 +0200
@@ -17,8 +17,6 @@
 #define MAX_HWIFS	4
 #endif
 
-#include <asm/arch/ide.h>
-
 /*
  * We always use the new IDE port registering,
  * so these are fixed here.
diff -puN include/linux/ide.h~arm_arch_ide include/linux/ide.h
--- linux-2.6.6-rc1-bk5/include/linux/ide.h~arm_arch_ide	2004-04-20 22:13:56.456543752 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/include/linux/ide.h	2004-04-20 22:13:56.478540408 +0200
@@ -310,18 +310,21 @@ static inline void ide_std_init_ports(hw
 /*
  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
  *
- * arm26, arm, h8300, m68k, m68knommu (broken) and i386-pc9800 (broken)
- * still have their own versions.
+ * arm-sa1100 (broken), h8300, m68k, m68knommu (broken)
+ * and i386-pc9800 (broken) still have their own versions.
  */
-#if !defined(CONFIG_ARM) && !defined(CONFIG_H8300) && !defined(CONFIG_M68K)
+#if !defined(CONFIG_H8300) && !defined(CONFIG_M68K)
 static inline void ide_init_hwif_ports(hw_regs_t *hw,
 				       unsigned long io_addr,
 				       unsigned long ctl_addr,
 				       int *irq)
 {
+#if !defined(CONFIG_ARM) || !defined(CONFIG_ARCH_L7200)
+#if !defined(CONFIG_ARM) || defined(CONFIG_ARCH_CLPS7500)
 	if (!ctl_addr)
 		ide_std_init_ports(hw, io_addr, io_addr + 0x206);
 	else
+#endif
 		ide_std_init_ports(hw, io_addr, ctl_addr);
 
 	if (irq)
@@ -333,8 +336,9 @@ static inline void ide_init_hwif_ports(h
 	if (ppc_ide_md.ide_init_hwif)
 		ppc_ide_md.ide_init_hwif(hw, io_addr, ctl_addr, irq);
 #endif
+#endif /* !ARM || !ARCH_L7200 */
 }
-#endif /* !ARM && !H8300 && !M68K */
+#endif /* !H8300 && !M68K */
 
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR

_

