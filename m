From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 13/19] ide: remove deprecated rz1000 host driver
Date: Thu, 04 Feb 2016 14:44:10 +0100
Message-ID: <1454593456-3162-14-git-send-email-b.zolnierkie@samsung.com>
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

The replacement driver (pata_rz1000) has been available since
2006 and it supports all the hardware supported by the old
rz1000 host driver.  Also x86 defconfigs have switched to use
libata PATA exclusively in 2008.

Remove the deprecated rz1000 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig  | 13 -------
 drivers/ide/Makefile |  1 -
 drivers/ide/rz1000.c | 99 ----------------------------------------------------
 3 files changed, 113 deletions(-)
 delete mode 100644 drivers/ide/rz1000.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 35a4bed..e4794af 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -314,19 +314,6 @@ config BLK_DEV_GENERIC
           This option provides generic support for various PCI IDE Chipsets
           which otherwise might not be supported.
 
-config BLK_DEV_RZ1000
-	tristate "RZ1000 chipset bugfix/support"
-	depends on X86
-	select BLK_DEV_IDEPCI
-	help
-	  The PC-Technologies RZ1000 IDE chip is used on many common 486 and
-	  Pentium motherboards, usually along with the "Neptune" chipset.
-	  Unfortunately, it has a rather nasty design flaw that can cause
-	  severe data corruption under many conditions. Say Y here to include
-	  code which automatically detects and corrects the problem under
-	  Linux. This may slow disk throughput by a few percent, but at least
-	  things will operate 100% reliably.
-
 config BLK_DEV_IDEDMA_PCI
 	bool
 	select BLK_DEV_IDEPCI
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index fa4221b..de19568 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_BLK_DEV_IT8172)		+= it8172.o
 obj-$(CONFIG_BLK_DEV_NS87415)		+= ns87415.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_NEW)	+= pdc202xx_new.o
 obj-$(CONFIG_BLK_DEV_PIIX)		+= piix.o
-obj-$(CONFIG_BLK_DEV_RZ1000)		+= rz1000.o
 obj-$(CONFIG_BLK_DEV_SVWKS)		+= serverworks.o
 obj-$(CONFIG_BLK_DEV_SGIIOC4)		+= sgiioc4.o
 obj-$(CONFIG_BLK_DEV_SIIMAGE)		+= siimage.o
diff --git a/drivers/ide/rz1000.c b/drivers/ide/rz1000.c
deleted file mode 100644
index f4b66f7..0000000
--- a/drivers/ide/rz1000.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- *  Copyright (C) 1995-1998  Linus Torvalds & author (see below)
- */
-
-/*
- *  Principal Author:  mlord@pobox.com (Mark Lord)
- *
- *  See linux/MAINTAINERS for address of current maintainer.
- *
- *  This file provides support for disabling the buggy read-ahead
- *  mode of the RZ1000 IDE chipset, commonly used on Intel motherboards.
- *
- *  Dunno if this fixes both ports, or only the primary port (?).
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#define DRV_NAME "rz1000"
-
-static int rz1000_disable_readahead(struct pci_dev *dev)
-{
-	u16 reg;
-
-	if (!pci_read_config_word (dev, 0x40, &reg) &&
-	    !pci_write_config_word(dev, 0x40, reg & 0xdfff)) {
-		printk(KERN_INFO "%s: disabled chipset read-ahead "
-			"(buggy RZ1000/RZ1001)\n", pci_name(dev));
-		return 0;
-	} else {
-		printk(KERN_INFO "%s: serialized, disabled unmasking "
-			"(buggy RZ1000/RZ1001)\n", pci_name(dev));
-		return 1;
-	}
-}
-
-static const struct ide_port_info rz1000_chipset = {
-	.name		= DRV_NAME,
-	.host_flags	= IDE_HFLAG_NO_DMA,
-};
-
-static int rz1000_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	struct ide_port_info d = rz1000_chipset;
-	int rc;
-
-	rc = pci_enable_device(dev);
-	if (rc)
-		return rc;
-
-	if (rz1000_disable_readahead(dev)) {
-		d.host_flags |= IDE_HFLAG_SERIALIZE;
-		d.host_flags |= IDE_HFLAG_NO_UNMASK_IRQS;
-	}
-
-	return ide_pci_init_one(dev, &d, NULL);
-}
-
-static void rz1000_remove(struct pci_dev *dev)
-{
-	ide_pci_remove(dev);
-	pci_disable_device(dev);
-}
-
-static const struct pci_device_id rz1000_pci_tbl[] = {
-	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000), 0 },
-	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001), 0 },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE(pci, rz1000_pci_tbl);
-
-static struct pci_driver rz1000_pci_driver = {
-	.name		= "RZ1000_IDE",
-	.id_table	= rz1000_pci_tbl,
-	.probe		= rz1000_init_one,
-	.remove		= rz1000_remove,
-};
-
-static int __init rz1000_ide_init(void)
-{
-	return ide_pci_register_driver(&rz1000_pci_driver);
-}
-
-static void __exit rz1000_ide_exit(void)
-{
-	pci_unregister_driver(&rz1000_pci_driver);
-}
-
-module_init(rz1000_ide_init);
-module_exit(rz1000_ide_exit);
-
-MODULE_AUTHOR("Andre Hedrick");
-MODULE_DESCRIPTION("PCI driver module for RZ1000 IDE");
-MODULE_LICENSE("GPL");
-
-- 
1.9.1
