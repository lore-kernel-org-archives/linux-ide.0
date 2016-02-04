From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 18/19] ide: remove deprecated ide-pnp host driver
Date: Thu, 04 Feb 2016 14:44:15 +0100
Message-ID: <1454593456-3162-19-git-send-email-b.zolnierkie@samsung.com>
References: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.

The replacement driver (pata_isapnp) has been available since
2006 and it supports all the hardware supported by the old
ide-pnp host driver.

Remove the deprecated ide-pnp host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig   |   8 ----
 drivers/ide/Makefile  |   1 -
 drivers/ide/ide-pnp.c | 100 --------------------------------------------------
 3 files changed, 109 deletions(-)
 delete mode 100644 drivers/ide/ide-pnp.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 486601c..0ce294b 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -252,14 +252,6 @@ config BLK_DEV_CMD640_ENHANCED
 	  and your BIOS does not already do this for you, then say Y here.
 	  Otherwise say N.
 
-config BLK_DEV_IDEPNP
-	tristate "PNP EIDE support"
-	depends on PNP
-	help
-	  If you have a PnP (Plug and Play) compatible EIDE card and
-	  would like the kernel to automatically detect and activate
-	  it, say Y here.
-
 config BLK_DEV_IDEDMA_SFF
 	bool
 
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 0f3cc1a..f78616fe 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -61,7 +61,6 @@ obj-$(CONFIG_BLK_DEV_CMD640)		+= cmd640.o
 obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+= pmac.o
 
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
-obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
 ide-gd_mod-y += ide-gd.o
 ide-cd_mod-y += ide-cd.o ide-cd_ioctl.o ide-cd_verbose.o
diff --git a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
deleted file mode 100644
index f5f2b62..0000000
--- a/drivers/ide/ide-pnp.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * This file provides autodetection for ISA PnP IDE interfaces.
- * It was tested with "ESS ES1868 Plug and Play AudioDrive" IDE interface.
- *
- * Copyright (C) 2000 Andrey Panin <pazke@donpac.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * You should have received a copy of the GNU General Public License
- * (for example /usr/src/linux/COPYING); if not, write to the Free
- * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/pnp.h>
-#include <linux/ide.h>
-#include <linux/module.h>
-
-#define DRV_NAME "ide-pnp"
-
-/* Add your devices here :)) */
-static struct pnp_device_id idepnp_devices[] = {
-	/* Generic ESDI/IDE/ATA compatible hard disk controller */
-	{.id = "PNP0600", .driver_data = 0},
-	{.id = ""}
-};
-
-static const struct ide_port_info ide_pnp_port_info = {
-	.host_flags		= IDE_HFLAG_NO_DMA,
-	.chipset		= ide_generic,
-};
-
-static int idepnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
-{
-	struct ide_host *host;
-	unsigned long base, ctl;
-	int rc;
-	struct ide_hw hw, *hws[] = { &hw };
-
-	printk(KERN_INFO DRV_NAME ": generic PnP IDE interface\n");
-
-	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_valid(dev, 0)))
-		return -1;
-
-	base = pnp_port_start(dev, 0);
-	ctl = pnp_port_start(dev, 1);
-
-	if (!request_region(base, 8, DRV_NAME)) {
-		printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",
-				DRV_NAME, base, base + 7);
-		return -EBUSY;
-	}
-
-	if (!request_region(ctl, 1, DRV_NAME)) {
-		printk(KERN_ERR "%s: I/O resource 0x%lX not free.\n",
-				DRV_NAME, ctl);
-		release_region(base, 8);
-		return -EBUSY;
-	}
-
-	memset(&hw, 0, sizeof(hw));
-	ide_std_init_ports(&hw, base, ctl);
-	hw.irq = pnp_irq(dev, 0);
-
-	rc = ide_host_add(&ide_pnp_port_info, hws, 1, &host);
-	if (rc)
-		goto out;
-
-	pnp_set_drvdata(dev, host);
-
-	return 0;
-out:
-	release_region(ctl, 1);
-	release_region(base, 8);
-
-	return rc;
-}
-
-static void idepnp_remove(struct pnp_dev *dev)
-{
-	struct ide_host *host = pnp_get_drvdata(dev);
-
-	ide_host_remove(host);
-
-	release_region(pnp_port_start(dev, 1), 1);
-	release_region(pnp_port_start(dev, 0), 8);
-}
-
-static struct pnp_driver idepnp_driver = {
-	.name		= "ide",
-	.id_table	= idepnp_devices,
-	.probe		= idepnp_probe,
-	.remove		= idepnp_remove,
-};
-
-module_pnp_driver(idepnp_driver);
-MODULE_LICENSE("GPL");
-- 
1.9.1
