From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] sanitize ARM26 A5K and ARM CLPS7500/RPC/Shark IDE support
Date: Tue, 20 Apr 2004 23:26:04 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404202326.04936.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59330 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264253AbUDUB7z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Apr 2004 21:59:55 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: John Appleby <john@dnsworld.co.uk>, Russell King <rmk@arm.linux.org.uk>, Alexander Schulz <alex@shark-linux.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org


Hi,

Please take a look...

Cheers,
Bartlomiej

[PATCH] sanitize ARM26 A5K and ARM CLPS7500/RPC/Shark IDE support

Add drivers/ide/ide_arm.c driver doing default IDE interface initialization
(no change in functionality) and clean ide_init_default_hwifs() for:

	asm-arm26/ide.h
	asm-arm/arch-cl7500/ide.h
	asm-arm/arch-rpc/ide.h
	asm-arm/arch-shark/ide.h

Cross-compile tested on ARM.

 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/Kconfig               |    5 +
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/Makefile              |    3 
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/arm/ide_arm.c         |   43 ++++++++++
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/ide.c                 |    5 +
 linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/arch-cl7500/ide.h |   16 ---
 linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/arch-rpc/ide.h    |   15 ---
 linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/arch-shark/ide.h  |   17 ---
 linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm26/ide.h           |   18 ----
 8 files changed, 60 insertions(+), 62 deletions(-)

diff -puN /dev/null drivers/ide/arm/ide_arm.c
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/arm/ide_arm.c	2004-04-20 22:12:50.973498688 +0200
@@ -0,0 +1,43 @@
+/*
+ * ARM26 A5K and ARM CLPS7500/RPC/Shark IDE host driver
+ *
+ * Copyright (C) 2004 Bartlomiej Zolnierkiewicz
+ * Based on code by Russell King and Alexander Schulz.
+ *
+ * May be copied or modified under the terms of the GNU General Public License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+
+#include <asm/irq.h>
+#include <asm/hardware.h>	/* for ISASLOT_IO */
+#include <asm/mach-types.h>	/* for machine_is_a5k() */
+
+static inline void
+arm_init_hwif(ide_hwif_t *hwif, unsigned long io, unsigned long ctl, int irq)
+{
+	if (hwif->chipset != ide_forced) {
+		hw_regs_t *hw = &hwif->hw;
+
+		memset(hw, 0, sizeof(*hw));
+		ide_std_init_ports(hw, io, ctl);
+		memcpy(hwif->io_ports, hw->io_ports, sizeof(hw->io_ports));
+		hwif->irq = hw->irq = irq;
+		hwif->noprobe = 0;
+	}
+}
+
+void __init ide_arm_init(void)
+{
+#ifdef CONFIG_ARM26
+	if (machine_is_a5k())
+		arm_init_hwif(&ide_hwifs[0], 0x1f0, 0x3f6, IRQ_HARDDISK);
+#elif defined(CONFIG_ARCH_CLPS7500)
+	arm_init_hwif(&ide_hwifs[0],
+		ISASLOT_IO + 0x1f0, ISASLOT_IO + 0x3f6, IRQ_ISA_14);
+#else
+	arm_init_hwif(&ide_hwifs[0], 0x1f0, 0x3f6, IRQ_HARDDISK);
+#endif
+}
diff -puN drivers/ide/ide.c~ide_arm drivers/ide/ide.c
--- linux-2.6.6-rc1-bk5/drivers/ide/ide.c~ide_arm	2004-04-20 22:12:50.932504920 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/ide.c	2004-04-20 22:12:50.975498384 +0200
@@ -2363,6 +2363,8 @@ struct bus_type ide_bus_type = {
 	.resume		= generic_ide_resume,
 };
 
+extern void ide_arm_init(void);
+
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
@@ -2380,6 +2382,9 @@ int __init ide_init (void)
 	proc_ide_root = proc_mkdir("ide", 0);
 #endif
 
+#ifdef CONFIG_IDE_ARM
+	ide_arm_init();
+#endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 	if (probe_ali14xx)
 		(void)ali14xx_init();
diff -puN drivers/ide/Kconfig~ide_arm drivers/ide/Kconfig
--- linux-2.6.6-rc1-bk5/drivers/ide/Kconfig~ide_arm	2004-04-20 22:12:50.936504312 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/Kconfig	2004-04-20 22:12:50.977498080 +0200
@@ -855,6 +855,11 @@ config BLK_DEV_IDE_SWARM
 	bool "SWARM onboard IDE support"
 	depends on SIBYTE_SWARM
 
+config IDE_ARM
+	bool
+	depends on ARM && (ARM26 || ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
+	default y
+
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
 	depends on ARM && ARCH_ACORN
diff -puN drivers/ide/Makefile~ide_arm drivers/ide/Makefile
--- linux-2.6.6-rc1-bk5/drivers/ide/Makefile~ide_arm	2004-04-20 22:12:50.949502336 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/Makefile	2004-04-20 22:12:50.978497928 +0200
@@ -25,6 +25,9 @@ ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= id
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
+# built-in only drivers from arm/
+ide-core-$(CONFIG_IDE_ARM)		+= arm/ide_arm.o
+
 # built-in only drivers from legacy/
 ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= legacy/pc9800.o
 ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= legacy/buddha.o
diff -puN include/asm-arm26/ide.h~ide_arm include/asm-arm26/ide.h
--- linux-2.6.6-rc1-bk5/include/asm-arm26/ide.h~ide_arm	2004-04-20 22:12:50.953501728 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm26/ide.h	2004-04-20 22:12:50.978497928 +0200
@@ -47,23 +47,7 @@ static inline void ide_init_hwif_ports(h
 
 #define ide_init_default_irq(base)	(0)
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-        if (machine_is_a5k()) {
-                hw_regs_t hw;
-
-                memset(&hw, 0, sizeof(hw));
-
-                ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-                hw.irq = IRQ_HARDDISK;
-                ide_register_hw(&hw,NULL);
-        }
-}
-
+static inline void ide_init_default_hwifs(void) { ; }
 
 /*
  * We always use the new IDE port registering,
diff -puN include/asm-arm/arch-cl7500/ide.h~ide_arm include/asm-arm/arch-cl7500/ide.h
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-cl7500/ide.h~ide_arm	2004-04-20 22:12:50.958500968 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/arch-cl7500/ide.h	2004-04-20 22:12:50.979497776 +0200
@@ -6,8 +6,6 @@
  * Modifications:
  *  29-07-1998	RMK	Major re-work of IDE architecture specific code
  */
-#include <asm/irq.h>
-#include <asm/arch/hardware.h>
 
 /*
  * Set up a hw structure for a specified data port, control port and IRQ.
@@ -35,16 +33,4 @@ static inline void ide_init_hwif_ports(h
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-
-	ide_init_hwif_ports(&hw, ISASLOT_IO + 0x1f0, ISASLOT_IO + 0x3f6, NULL);
-	hw.irq = IRQ_ISA_14;
-	ide_register_hw(&hw);
-}
+static inline void ide_init_default_hwifs(void) { ; }
diff -puN include/asm-arm/arch-rpc/ide.h~ide_arm include/asm-arm/arch-rpc/ide.h
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-rpc/ide.h~ide_arm	2004-04-20 22:12:50.962500360 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/arch-rpc/ide.h	2004-04-20 22:12:50.981497472 +0200
@@ -10,7 +10,6 @@
  *  Modifications:
  *   29-07-1998	RMK	Major re-work of IDE architecture specific code
  */
-#include <asm/irq.h>
 
 /*
  * Set up a hw structure for a specified data port, control port and IRQ.
@@ -33,16 +32,4 @@ static inline void ide_init_hwif_ports(h
 		*irq = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-
-	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-	hw.irq = IRQ_HARDDISK;
-	ide_register_hw(&hw, NULL);
-}
+static inline void ide_init_default_hwifs(void) { ; }
diff -puN include/asm-arm/arch-shark/ide.h~ide_arm include/asm-arm/arch-shark/ide.h
--- linux-2.6.6-rc1-bk5/include/asm-arm/arch-shark/ide.h~ide_arm	2004-04-20 22:12:50.966499752 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/include/asm-arm/arch-shark/ide.h	2004-04-20 22:12:50.981497472 +0200
@@ -8,8 +8,6 @@
  * Copyright (c) 1998 Russell King
  */
 
-#include <asm/irq.h>
-
 /*
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
@@ -31,17 +29,4 @@ static inline void ide_init_hwif_ports(h
 		*irq = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-	hw_regs_t hw;
-
-	ide_init_hwif_ports(&hw, 0x1f0, 0x3f6, NULL);
-	hw.irq = 14;
-	ide_register_hw(&hw,NULL);
-}
-
+static inline void ide_init_default_hwifs(void) { ; }

_

