From: Ben Dooks <ben-ide@fluff.org>
Subject: [PATCH] Simtec BAST (EB2410ITX) / Thorcom VR1000 driver
Date: Tue, 28 Sep 2004 15:58:28 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040928145828.GH22627@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:62377
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S267872AbUI1O63 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Sep 2004 10:58:29 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

Patch to provide support for the following two boards:

	- Simtec BAST (EB2410ITX)
	- Thorcom VR1000

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 drivers/ide/Kconfig        |    7 +++
 drivers/ide/arm/Makefile   |    1 
 drivers/ide/arm/bast-ide.c |   80 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff -urN -X ../dontdiff linux-2.6.9-rc2-bk11/drivers/ide/Kconfig linux-2.6.9-rc2-bk11-ide1/drivers/ide/Kconfig
--- linux-2.6.9-rc2-bk11/drivers/ide/Kconfig	2004-09-26 12:40:31.000000000 +0100
+++ linux-2.6.9-rc2-bk11-ide1/drivers/ide/Kconfig	2004-09-28 14:58:52.000000000 +0100
@@ -830,6 +830,13 @@
 	  Say Y here if you want to support the Yellowstone RapIDE controller
 	  manufactured for use with Acorn computers.
 
+config BLK_DEV_IDE_BAST
+	tristate "Simtec BAST / Thorcom VR1000 IDE support"
+	depends on ARM && (ARCH_BAST || MACH_VR100)
+	help
+	  Say Y here if you want to support the onboard IDE channels on the
+	  Simtec BAST or the Thorcom VR1000
+
 config BLK_DEV_GAYLE
 	bool "Amiga Gayle IDE interface support"
 	depends on AMIGA
diff -urN -X ../dontdiff linux-2.6.9-rc2-bk11/drivers/ide/arm/Makefile linux-2.6.9-rc2-bk11-ide1/drivers/ide/arm/Makefile
--- linux-2.6.9-rc2-bk11/drivers/ide/arm/Makefile	2004-08-14 06:36:11.000000000 +0100
+++ linux-2.6.9-rc2-bk11-ide1/drivers/ide/arm/Makefile	2004-09-28 14:55:39.000000000 +0100
@@ -1,5 +1,6 @@
 
 obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
+obj-$(CONFIG_BLK_DEV_IDE_BAST)		+= bast-ide.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
diff -urN -X ../dontdiff linux-2.6.9-rc2-bk11/drivers/ide/arm/bast-ide.c linux-2.6.9-rc2-bk11-ide1/drivers/ide/arm/bast-ide.c
--- linux-2.6.9-rc2-bk11/drivers/ide/arm/bast-ide.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2-bk11-ide1/drivers/ide/arm/bast-ide.c	2004-09-28 15:16:17.000000000 +0100
@@ -0,0 +1,80 @@
+/* linux/drivers/ide/arm/bast-ide.c
+ *
+ * Copyright (c) 2003-2004 Simtec Electronics
+ *  Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/mach-types.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/arch/map.h>
+#include <asm/arch/bast-map.h>
+#include <asm/arch/bast-irq.h>
+
+/* list of registered interfaces */
+static ide_hwif_t *ifs[2];
+
+static int __init
+bastide_register(unsigned int base, unsigned int aux, int irq,
+		 ide_hwif_t **hwif)
+{
+	hw_regs_t hw;
+	int i;
+
+	memset(&hw, 0, sizeof(hw));
+
+	base += BAST_IDE_CS;
+	aux  += BAST_IDE_CS;
+
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+		hw.io_ports[i] = (unsigned long)base;
+		base += 0x20;
+	}
+
+	hw.io_ports[IDE_CONTROL_OFFSET] = aux + (6 * 0x20);
+	hw.irq = irq;
+
+	ide_register_hw(&hw, hwif);
+
+	return 0;
+}
+
+static int __init bastide_init(void)
+{
+	/* we can treat the VR1000 and the BAST the same */
+
+	if (!(machine_is_bast() || machine_is_vr1000()))
+		return 0;
+
+	printk("BAST: IDE driver, (c) 2003-2004 Simtec Electronics\n");
+
+	bastide_register(BAST_VA_IDEPRI, BAST_VA_IDEPRIAUX, IRQ_IDE0, &ifs[0]);
+	bastide_register(BAST_VA_IDESEC, BAST_VA_IDESECAUX, IRQ_IDE1, &ifs[1]);
+	return 0;
+}
+
+static void __exit bastide_exit()
+{
+	if (ifs[0] != NULL)
+		ide_unregister(ifs[0] - ide_hwifs);
+	if (ifs[1] != NULL)
+		ide_unregister(ifs[1] - ide_hwifs);
+}
+
+module_init(bastide_init);
+module_exit(bastide_exit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simtec BAST / Thorcom VR1000 IDE driver");
