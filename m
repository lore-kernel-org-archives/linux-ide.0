From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] SWARM IDE: Fix up following changes to ide_hwif_t
Date: Tue, 6 May 2008 00:40:20 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805060031350.7061@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761517AbYEEXks@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

 Following recent changes to ide_hwif_t update the SWARM IDE driver to use 
hw_regs_t to initialize port mapping.  Plus minor layout adjustments along 
the lines of other drivers.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Fixes a build problem.  Tested succesfully at the run time.  No
checkpatch.pl problems.  Please apply.

  Maciej

patch-2.6.26-rc1-20080505-swarm-ide-hw-0
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/ide/mips/swarm.c linux-2.6.26-rc1-20080505/drivers/ide/mips/swarm.c
--- linux-2.6.26-rc1-20080505.macro/drivers/ide/mips/swarm.c	2008-05-05 02:55:26.000000000 +0000
+++ linux-2.6.26-rc1-20080505/drivers/ide/mips/swarm.c	2008-05-05 23:02:04.000000000 +0000
@@ -4,7 +4,7 @@
  *	Author:	Manish Lachwani, mlachwani@mvista.com
  * Copyright (C) 2004  MIPS Technologies, Inc.  All rights reserved.
  *	Author: Maciej W. Rozycki <macro@mips.com>
- * Copyright (c) 2006  Maciej W. Rozycki
+ * Copyright (c) 2006, 2008  Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -70,8 +70,9 @@ static int __devinit swarm_ide_probe(str
 	ide_hwif_t *hwif;
 	u8 __iomem *base;
 	phys_t offset, size;
+	hw_regs_t hw;
 	int i;
-	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	u8 idx[] = { 0xff, 0xff, 0xff, 0xff };
 
 	if (!SIBYTE_HAVE_IDE)
 		return -ENODEV;
@@ -112,14 +113,15 @@ static int __devinit swarm_ide_probe(str
 	hwif->host_flags = IDE_HFLAG_MMIO;
 	default_hwif_mmiops(hwif);
 
-	hwif->chipset = ide_generic;
-
 	for (i = 0; i <= 7; i++)
-		hwif->io_ports_array[i] =
+		hw.io_ports_array[i] =
 				(unsigned long)(base + ((0x1f0 + i) << 5));
-	hwif->io_ports.ctl_addr =
+	hw.io_ports.ctl_addr =
 				(unsigned long)(base + (0x3f6 << 5));
-	hwif->irq = K_INT_GB_IDE;
+	hw.irq = K_INT_GB_IDE;
+	hw.chipset = ide_generic;
+
+	ide_init_port_hw(hwif, &hw);
 
 	idx[0] = hwif->index;
 
