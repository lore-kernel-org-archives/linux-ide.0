From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 2/2] BAST: Remove old IDE driver
Date: Mon, 16 Jun 2008 12:16:27 +0100
Message-ID: <20080616112453.008960070@fluff.org.uk>
References: <20080616111625.145158959@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:63524 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751564AbYFPLZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 07:25:07 -0400
Content-Disposition: inline; filename=simtec/simtec-drivers-ata-remove-bast-ide.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, bzolnier@gmail.com, Ben Dooks <ben-linux@fluff.org>

Remove the old BAST IDE driver, as we are now using the platform-pata
support.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc6-quilt1/drivers/ide/Kconfig
===================================================================
--- linux-2.6.26-rc6-quilt1.orig/drivers/ide/Kconfig	2008-06-16 11:54:50.000000000 +0100
+++ linux-2.6.26-rc6-quilt1/drivers/ide/Kconfig	2008-06-16 12:02:45.000000000 +0100
@@ -823,13 +823,6 @@ config BLK_DEV_IDE_RAPIDE
 	  Say Y here if you want to support the Yellowstone RapIDE controller
 	  manufactured for use with Acorn computers.
 
-config BLK_DEV_IDE_BAST
-	tristate "Simtec BAST / Thorcom VR1000 IDE support"
-	depends on ARM && (ARCH_BAST || MACH_VR1000)
-	help
-	  Say Y here if you want to support the onboard IDE channels on the
-	  Simtec BAST or the Thorcom VR1000
-
 config IDE_H8300
 	tristate "H8300 IDE support"
 	depends on H8300
Index: linux-2.6.26-rc6-quilt1/drivers/ide/arm/Makefile
===================================================================
--- linux-2.6.26-rc6-quilt1.orig/drivers/ide/arm/Makefile	2008-06-16 12:03:24.000000000 +0100
+++ linux-2.6.26-rc6-quilt1/drivers/ide/arm/Makefile	2008-06-16 12:03:27.000000000 +0100
@@ -1,7 +1,6 @@
 
 obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
-obj-$(CONFIG_BLK_DEV_IDE_BAST)		+= bast-ide.o
 obj-$(CONFIG_BLK_DEV_PALMCHIP_BK3710)	+= palm_bk3710.o
 
 ifeq ($(CONFIG_IDE_ARM), m)
Index: linux-2.6.26-rc6-quilt1/drivers/ide/arm/bast-ide.c
===================================================================
--- linux-2.6.26-rc6-quilt1.orig/drivers/ide/arm/bast-ide.c	2008-06-16 12:03:14.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,90 +0,0 @@
-/*
- * Copyright (c) 2003-2004 Simtec Electronics
- *  Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#include <asm/mach-types.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/arch/map.h>
-#include <asm/arch/bast-map.h>
-#include <asm/arch/bast-irq.h>
-
-#define DRV_NAME "bast-ide"
-
-static int __init bastide_register(unsigned int base, unsigned int aux, int irq)
-{
-	ide_hwif_t *hwif;
-	hw_regs_t hw;
-	int i;
-	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
-
-	memset(&hw, 0, sizeof(hw));
-
-	base += BAST_IDE_CS;
-	aux  += BAST_IDE_CS;
-
-	for (i = 0; i <= 7; i++) {
-		hw.io_ports_array[i] = (unsigned long)base;
-		base += 0x20;
-	}
-
-	hw.io_ports.ctl_addr = aux + (6 * 0x20);
-	hw.irq = irq;
-	hw.chipset = ide_generic;
-
-	hwif = ide_find_port();
-	if (hwif == NULL)
-		goto out;
-
-	i = hwif->index;
-
-	ide_init_port_data(hwif, i);
-	ide_init_port_hw(hwif, &hw);
-	hwif->port_ops = NULL;
-
-	idx[0] = i;
-
-	ide_device_add(idx, NULL);
-out:
-	return 0;
-}
-
-static int __init bastide_init(void)
-{
-	unsigned long base = BAST_VA_IDEPRI + BAST_IDE_CS;
-
-	/* we can treat the VR1000 and the BAST the same */
-
-	if (!(machine_is_bast() || machine_is_vr1000()))
-		return 0;
-
-	printk("BAST: IDE driver, (c) 2003-2004 Simtec Electronics\n");
-
-	if (!request_mem_region(base, 0x400000, DRV_NAME)) {
-		printk(KERN_ERR "%s: resources busy\n", DRV_NAME);
-		return -EBUSY;
-	}
-
-	bastide_register(BAST_VA_IDEPRI, BAST_VA_IDEPRIAUX, IRQ_IDE0);
-	bastide_register(BAST_VA_IDESEC, BAST_VA_IDESECAUX, IRQ_IDE1);
-
-	return 0;
-}
-
-module_init(bastide_init);
-
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Simtec BAST / Thorcom VR1000 IDE driver");

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
