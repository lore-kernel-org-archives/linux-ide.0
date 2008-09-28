From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
	driver
Date: Sun, 28 Sep 2008 18:54:50 +0100
Message-ID: <20080928175450.GA8478@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:54376
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751833AbYI1RzI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Sep 2008 13:55:08 -0400
Content-Disposition: inline
In-Reply-To: <20080928113931.GA9207@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

The Swarm IDE driver uses a release method which is defined in the driver
itself thus potentially oopsable.  The simple fix would be to just leak
the device but this patch goes the full length and moves the entire
handling of the platform device in the platform code and retains only
the platform driver code in drivers/ide/mips/swarm.c.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
This patch is for 2.6.27.  The same issue exists in -stable but the patch
won't apply due to other driver changes.

Changes: v2 rewritten to use pata_platform, as suggested.

 arch/mips/sibyte/swarm/Makefile   |    3 
 arch/mips/sibyte/swarm/platform.c |   81 +++++++++++++++
 drivers/ide/mips/Makefile         |    1 
 drivers/ide/mips/swarm.c          |  197 --------------------------------------
 4 files changed, 83 insertions(+), 199 deletions(-)

Index: linux-mips/arch/mips/sibyte/swarm/platform.c
===================================================================
--- /dev/null
+++ linux-mips/arch/mips/sibyte/swarm/platform.c
@@ -0,0 +1,81 @@
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+
+#include <asm/sibyte/board.h>
+#include <asm/sibyte/sb1250_genbus.h>
+#include <asm/sibyte/sb1250_regs.h>
+
+#define DRV_NAME	"pata-swarm"
+
+#define SWARM_IDE_SHIFT	5
+#define SWARM_IDE_BASE	0x1f0
+#define SWARM_IDE_CTRL	0x3f6
+
+static struct resource swarm_pata_resource[] = {
+	{
+		.name	= "Swarm GenBus IDE",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.name	= "Swarm GenBus IDE",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.name	= "Swarm GenBus IDE",
+		.flags	= IORESOURCE_IRQ,
+		.start	= K_INT_GB_IDE,
+		.end	= K_INT_GB_IDE,
+	},
+};
+
+static struct pata_platform_info pata_platform_data = {
+	.ioport_shift	= SWARM_IDE_SHIFT,
+};
+
+static struct platform_device swarm_pata_device = {
+	.name		= "pata_platform",
+	.id		= -1,
+	.resource	= swarm_pata_resource,
+	.num_resources	= ARRAY_SIZE(swarm_pata_resource),
+	.dev  = {
+		.platform_data		= &pata_platform_data,
+		.coherent_dma_mask	= ~0,	/* grumble */
+	},
+};
+
+static int __init swarm_pata_init(void)
+{
+	u8 __iomem *base;
+	phys_t offset, size;
+	struct resource *r;
+
+	if (!SIBYTE_HAVE_IDE)
+		return -ENODEV;
+
+	base = ioremap(A_IO_EXT_BASE, 0x800);
+	offset = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_START_ADDR, IDE_CS));
+	size = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_MULT_SIZE, IDE_CS));
+	iounmap(base);
+
+	offset = G_IO_START_ADDR(offset) << S_IO_ADDRBASE;
+	size = (G_IO_MULT_SIZE(size) + 1) << S_IO_REGSIZE;
+	if (offset < A_PHYS_GENBUS || offset >= A_PHYS_GENBUS_END) {
+		pr_info(DRV_NAME ": PATA interface at GenBus disabled\n");
+
+		return -EBUSY;
+	}
+
+	pr_info(DRV_NAME ": PATA interface at GenBus slot %i\n", IDE_CS);
+
+	r = swarm_pata_resource;
+	r[0].start = offset + (SWARM_IDE_BASE << SWARM_IDE_SHIFT);
+	r[0].end   = offset + ((SWARM_IDE_BASE + 8) << SWARM_IDE_SHIFT) - 1;
+	r[1].start = offset + (SWARM_IDE_CTRL << SWARM_IDE_SHIFT);
+	r[1].end   = offset + ((SWARM_IDE_CTRL + 1) << SWARM_IDE_SHIFT) - 1;
+
+	return platform_device_register(&swarm_pata_device);
+}
+
+device_initcall(swarm_pata_init);
Index: linux-mips/arch/mips/sibyte/swarm/Makefile
===================================================================
--- linux-mips.orig/arch/mips/sibyte/swarm/Makefile
+++ linux-mips/arch/mips/sibyte/swarm/Makefile
@@ -1,3 +1,4 @@
-obj-y				:= setup.o rtc_xicor1241.o rtc_m41t81.o
+obj-y				:= platform.o setup.o rtc_xicor1241.o \
+				   rtc_m41t81.o
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= swarm-i2c.o
Index: linux-mips/drivers/ide/mips/swarm.c
===================================================================
--- linux-mips.orig/drivers/ide/mips/swarm.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * Copyright (C) 2001, 2002, 2003 Broadcom Corporation
- * Copyright (C) 2004 MontaVista Software Inc.
- *	Author:	Manish Lachwani, mlachwani@mvista.com
- * Copyright (C) 2004  MIPS Technologies, Inc.  All rights reserved.
- *	Author: Maciej W. Rozycki <macro@mips.com>
- * Copyright (c) 2006, 2008  Maciej W. Rozycki
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-/*
- *  Derived loosely from ide-pmac.c, so:
- *  Copyright (C) 1998 Paul Mackerras.
- *  Copyright (C) 1995-1998 Mark Lord
- */
-
-/*
- * Boards with SiByte processors so far have supported IDE devices via
- * the Generic Bus, PCI bus, and built-in PCMCIA interface.  In all
- * cases, byte-swapping must be avoided for these devices (whereas
- * other PCI devices, for example, will require swapping).  Any
- * SiByte-targetted kernel including IDE support will include this
- * file.  Probing of a Generic Bus for an IDE device is controlled by
- * the definition of "SIBYTE_HAVE_IDE", which is provided by
- * <asm/sibyte/board.h> for Broadcom boards.
- */
-
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/platform_device.h>
-
-#include <asm/io.h>
-
-#include <asm/sibyte/board.h>
-#include <asm/sibyte/sb1250_genbus.h>
-#include <asm/sibyte/sb1250_regs.h>
-
-#define DRV_NAME "ide-swarm"
-
-static char swarm_ide_string[] = DRV_NAME;
-
-static struct resource swarm_ide_resource = {
-	.name	= "SWARM GenBus IDE",
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct platform_device *swarm_ide_dev;
-
-static const struct ide_port_info swarm_port_info = {
-	.name			= DRV_NAME,
-	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
-};
-
-/*
- * swarm_ide_probe - if the board header indicates the existence of
- * Generic Bus IDE, allocate a HWIF for it.
- */
-static int __devinit swarm_ide_probe(struct device *dev)
-{
-	u8 __iomem *base;
-	struct ide_host *host;
-	phys_t offset, size;
-	int i, rc;
-	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
-
-	if (!SIBYTE_HAVE_IDE)
-		return -ENODEV;
-
-	base = ioremap(A_IO_EXT_BASE, 0x800);
-	offset = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_START_ADDR, IDE_CS));
-	size = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_MULT_SIZE, IDE_CS));
-	iounmap(base);
-
-	offset = G_IO_START_ADDR(offset) << S_IO_ADDRBASE;
-	size = (G_IO_MULT_SIZE(size) + 1) << S_IO_REGSIZE;
-	if (offset < A_PHYS_GENBUS || offset >= A_PHYS_GENBUS_END) {
-		printk(KERN_INFO DRV_NAME
-		       ": IDE interface at GenBus disabled\n");
-		return -EBUSY;
-	}
-
-	printk(KERN_INFO DRV_NAME ": IDE interface at GenBus slot %i\n",
-	       IDE_CS);
-
-	swarm_ide_resource.start = offset;
-	swarm_ide_resource.end = offset + size - 1;
-	if (request_resource(&iomem_resource, &swarm_ide_resource)) {
-		printk(KERN_ERR DRV_NAME
-		       ": can't request I/O memory resource\n");
-		return -EBUSY;
-	}
-
-	base = ioremap(offset, size);
-
-	memset(&hw, 0, sizeof(hw));
-	for (i = 0; i <= 7; i++)
-		hw.io_ports_array[i] =
-				(unsigned long)(base + ((0x1f0 + i) << 5));
-	hw.io_ports.ctl_addr =
-				(unsigned long)(base + (0x3f6 << 5));
-	hw.irq = K_INT_GB_IDE;
-	hw.chipset = ide_generic;
-
-	rc = ide_host_add(&swarm_port_info, hws, &host);
-	if (rc)
-		goto err;
-
-	dev_set_drvdata(dev, host);
-
-	return 0;
-err:
-	release_resource(&swarm_ide_resource);
-	iounmap(base);
-	return rc;
-}
-
-static struct device_driver swarm_ide_driver = {
-	.name	= swarm_ide_string,
-	.bus	= &platform_bus_type,
-	.probe	= swarm_ide_probe,
-};
-
-static void swarm_ide_platform_release(struct device *device)
-{
-	struct platform_device *pldev;
-
-	/* free device */
-	pldev = to_platform_device(device);
-	kfree(pldev);
-}
-
-static int __devinit swarm_ide_init_module(void)
-{
-	struct platform_device *pldev;
-	int err;
-
-	printk(KERN_INFO "SWARM IDE driver\n");
-
-	if (driver_register(&swarm_ide_driver)) {
-		printk(KERN_ERR "Driver registration failed\n");
-		err = -ENODEV;
-		goto out;
-	}
-
-        if (!(pldev = kzalloc(sizeof (*pldev), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto out_unregister_driver;
-	}
-
-	pldev->name		= swarm_ide_string;
-	pldev->id		= 0;
-	pldev->dev.release	= swarm_ide_platform_release;
-
-	if (platform_device_register(pldev)) {
-		err = -ENODEV;
-		goto out_free_pldev;
-	}
-
-        if (!pldev->dev.driver) {
-		/*
-		 * The driver was not bound to this device, there was
-                 * no hardware at this address. Unregister it, as the
-		 * release fuction will take care of freeing the
-		 * allocated structure
-		 */
-		platform_device_unregister (pldev);
-	}
-
-	swarm_ide_dev = pldev;
-
-	return 0;
-
-out_free_pldev:
-	kfree(pldev);
-
-out_unregister_driver:
-	driver_unregister(&swarm_ide_driver);
-out:
-	return err;
-}
-
-module_init(swarm_ide_init_module);
Index: linux-mips/drivers/ide/mips/Makefile
===================================================================
--- linux-mips.orig/drivers/ide/mips/Makefile
+++ linux-mips/drivers/ide/mips/Makefile
@@ -1,4 +1,3 @@
-obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
 
 EXTRA_CFLAGS    := -Idrivers/ide
