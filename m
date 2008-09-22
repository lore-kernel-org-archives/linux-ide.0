From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
Date: Mon, 22 Sep 2008 14:29:08 +0200
Message-ID: <20080922122853.GA15210@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([213.58.128.207]:38300 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYIVMhI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 08:37:08 -0400
Received: from localhost.localdomain ([127.0.0.1]:47836 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20125408AbYIVM3Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 13:29:24 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

The Swarm IDE driver uses a release method which is defined in the driver
itself thus potencially oopsable.  The simpel fix would be to just leak
the device but this patch goes the full length and moves the entire
handling of the platform device in the platform code and retains only
the platform driver code in drivers/ide/mips/swarm.c.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

This patch is for 2.6.27.  The same issue exists in -stable but the patch
won't apply due to other driver changes.

 arch/mips/sibyte/swarm/Makefile   |    3 
 arch/mips/sibyte/swarm/platform.c |   60 ++++++++++++++++
 drivers/ide/mips/swarm.c          |  140 +++++++++++---------------------------
 3 files changed, 104 insertions(+), 99 deletions(-)

Index: linux-mips/arch/mips/sibyte/swarm/platform.c
===================================================================
--- /dev/null
+++ linux-mips/arch/mips/sibyte/swarm/platform.c
@@ -0,0 +1,60 @@
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <asm/sibyte/board.h>
+#include <asm/sibyte/sb1250_genbus.h>
+#include <asm/sibyte/sb1250_regs.h>
+
+#define DEV_NAME "ide-swarm"
+
+static struct resource swarm_ide_resource[] = {
+	{
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
+static int __init swarm_ide_init(void)
+{
+	struct platform_device *pdev;
+	u8 __iomem *base;
+	phys_t offset, size;
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
+		pr_info(DEV_NAME ": IDE interface at GenBus disabled\n");
+
+		return -EBUSY;
+	}
+
+	pr_info(DEV_NAME ": IDE interface at GenBus slot %i\n", IDE_CS);
+
+	swarm_ide_resource[0].start = offset;
+	swarm_ide_resource[0].end = offset + size - 1;
+
+	pdev = platform_device_register_simple(DEV_NAME, -1,
+		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+}
+
+device_initcall(swarm_ide_init);
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
+++ linux-mips/drivers/ide/mips/swarm.c
@@ -46,21 +46,10 @@
 
 #include <asm/io.h>
 
-#include <asm/sibyte/board.h>
-#include <asm/sibyte/sb1250_genbus.h>
-#include <asm/sibyte/sb1250_regs.h>
-
 #define DRV_NAME "ide-swarm"
 
 static char swarm_ide_string[] = DRV_NAME;
 
-static struct resource swarm_ide_resource = {
-	.name	= "SWARM GenBus IDE",
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct platform_device *swarm_ide_dev;
-
 static const struct ide_port_info swarm_port_info = {
 	.name			= DRV_NAME,
 	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
@@ -70,41 +59,18 @@ static const struct ide_port_info swarm_
  * swarm_ide_probe - if the board header indicates the existence of
  * Generic Bus IDE, allocate a HWIF for it.
  */
-static int __devinit swarm_ide_probe(struct device *dev)
+static int __devinit swarm_ide_probe(struct platform_device *pdev)
 {
 	u8 __iomem *base;
 	struct ide_host *host;
 	phys_t offset, size;
+	struct resource *r;
 	int i, rc;
 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
 
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
+	r = pdev->resource;
+	offset = r->start;
+	size = resource_size(r);
 	base = ioremap(offset, size);
 
 	memset(&hw, 0, sizeof(hw));
@@ -113,85 +79,63 @@ static int __devinit swarm_ide_probe(str
 				(unsigned long)(base + ((0x1f0 + i) << 5));
 	hw.io_ports.ctl_addr =
 				(unsigned long)(base + (0x3f6 << 5));
-	hw.irq = K_INT_GB_IDE;
+	hw.irq = r[1].start;
 	hw.chipset = ide_generic;
 
 	rc = ide_host_add(&swarm_port_info, hws, &host);
-	if (rc)
-		goto err;
+	if (rc) {
+		iounmap(base);
+
+		return rc;
+	}
 
-	dev_set_drvdata(dev, host);
+	platform_set_drvdata(pdev, host);
 
 	return 0;
-err:
-	release_resource(&swarm_ide_resource);
-	iounmap(base);
-	return rc;
 }
 
-static struct device_driver swarm_ide_driver = {
-	.name	= swarm_ide_string,
-	.bus	= &platform_bus_type,
-	.probe	= swarm_ide_probe,
-};
-
-static void swarm_ide_platform_release(struct device *device)
+static int __devexit swarm_ide_remove(struct platform_device *pdev)
 {
-	struct platform_device *pldev;
+	struct ide_host *host = pdev->dev.driver_data;
 
-	/* free device */
-	pldev = to_platform_device(device);
-	kfree(pldev);
+	ide_host_remove(host);
+
+	return 0;
 }
 
-static int __devinit swarm_ide_init_module(void)
+static struct platform_driver swarm_ide_driver = {
+	.driver = {
+		.name	= swarm_ide_string,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= swarm_ide_probe,
+	.remove = __devexit_p(swarm_ide_remove),
+};
+
+static int __init swarm_ide_init(void)
 {
-	struct platform_device *pldev;
 	int err;
 
-	printk(KERN_INFO "SWARM IDE driver\n");
-
-	if (driver_register(&swarm_ide_driver)) {
-		printk(KERN_ERR "Driver registration failed\n");
-		err = -ENODEV;
-		goto out;
-	}
+	pr_info("Swarm IDE driver\n");
 
-        if (!(pldev = kzalloc(sizeof (*pldev), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto out_unregister_driver;
-	}
+	err = platform_driver_register(&swarm_ide_driver);
+	if (err) {
+		pr_err("Driver registration failed\n");
 
-	pldev->name		= swarm_ide_string;
-	pldev->id		= 0;
-	pldev->dev.release	= swarm_ide_platform_release;
-
-	if (platform_device_register(pldev)) {
-		err = -ENODEV;
-		goto out_free_pldev;
+		return err;
 	}
 
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
 	return 0;
+}
 
-out_free_pldev:
-	kfree(pldev);
-
-out_unregister_driver:
-	driver_unregister(&swarm_ide_driver);
-out:
-	return err;
+static void __exit swarm_ide_exit(void)
+{
+	platform_driver_unregister(&swarm_ide_driver);
 }
 
-module_init(swarm_ide_init_module);
+MODULE_DESCRIPTION("Sibyte Swarm platform IDE driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ide-swarm");
+
+module_init(swarm_ide_init);
+module_exit(swarm_ide_exit);
