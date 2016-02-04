From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 10/19] ide: remove deprecated jmicron host driver
Date: Thu, 04 Feb 2016 14:44:07 +0100
Message-ID: <1454593456-3162-11-git-send-email-b.zolnierkie@samsung.com>
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

The replacement driver (pata_jmicron) has been available since
2006 and it supports all the hardware supported by the old
jmicron host driver.

Remove the deprecated jmicron host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig   |   7 --
 drivers/ide/Makefile  |   1 -
 drivers/ide/jmicron.c | 176 --------------------------------------------------
 3 files changed, 184 deletions(-)
 delete mode 100644 drivers/ide/jmicron.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index ac2b9f4..2458a1f 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -420,13 +420,6 @@ config BLK_DEV_HPT366
 	  ide-probe at boot. It is reported to support DVD II drives, by the
 	  manufacturer.
 
-config BLK_DEV_JMICRON
-	tristate "JMicron JMB36x support"
-	select BLK_DEV_IDEDMA_PCI
-	help
-	  Basic support for the JMicron ATA controllers. For full support
-	  use the libata drivers.
-
 config BLK_DEV_PIIX
 	tristate "Intel PIIX/ICH chipsets support"
 	select BLK_DEV_IDEDMA_PCI
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 94e8d17..90b64de 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 obj-$(CONFIG_BLK_DEV_IT8172)		+= it8172.o
-obj-$(CONFIG_BLK_DEV_JMICRON)		+= jmicron.o
 obj-$(CONFIG_BLK_DEV_NS87415)		+= ns87415.o
 obj-$(CONFIG_BLK_DEV_OPTI621)		+= opti621.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_OLD)	+= pdc202xx_old.o
diff --git a/drivers/ide/jmicron.c b/drivers/ide/jmicron.c
deleted file mode 100644
index ae6480d..0000000
--- a/drivers/ide/jmicron.c
+++ /dev/null
@@ -1,176 +0,0 @@
-
-/*
- * Copyright (C) 2006		Red Hat
- *
- *  May be copied or modified under the terms of the GNU General Public License
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#define DRV_NAME "jmicron"
-
-typedef enum {
-	PORT_PATA0 = 0,
-	PORT_PATA1 = 1,
-	PORT_SATA = 2,
-} port_type;
-
-/**
- *	jmicron_cable_detect	-	cable detection
- *	@hwif: IDE port
- *
- *	Returns the cable type.
- */
-
-static u8 jmicron_cable_detect(ide_hwif_t *hwif)
-{
-	struct pci_dev *pdev = to_pci_dev(hwif->dev);
-
-	u32 control;
-	u32 control5;
-
-	int port = hwif->channel;
-	port_type port_map[2];
-
-	pci_read_config_dword(pdev, 0x40, &control);
-
-	/* There are two basic mappings. One has the two SATA ports merged
-	   as master/slave and the secondary as PATA, the other has only the
-	   SATA port mapped */
-	if (control & (1 << 23)) {
-		port_map[0] = PORT_SATA;
-		port_map[1] = PORT_PATA0;
-	} else {
-		port_map[0] = PORT_SATA;
-		port_map[1] = PORT_SATA;
-	}
-
-	/* The 365/366 may have this bit set to map the second PATA port
-	   as the internal primary channel */
-	pci_read_config_dword(pdev, 0x80, &control5);
-	if (control5 & (1<<24))
-		port_map[0] = PORT_PATA1;
-
-	/* The two ports may then be logically swapped by the firmware */
-	if (control & (1 << 22))
-		port = port ^ 1;
-
-	/*
-	 *	Now we know which physical port we are talking about we can
-	 *	actually do our cable checking etc. Thankfully we don't need
-	 *	to do the plumbing for other cases.
-	 */
-	switch (port_map[port]) {
-	case PORT_PATA0:
-		if (control & (1 << 3))	/* 40/80 pin primary */
-			return ATA_CBL_PATA40;
-		return ATA_CBL_PATA80;
-	case PORT_PATA1:
-		if (control5 & (1 << 19))	/* 40/80 pin secondary */
-			return ATA_CBL_PATA40;
-		return ATA_CBL_PATA80;
-	case PORT_SATA:
-		break;
-	}
-	/* Avoid bogus "control reaches end of non-void function" */
-	return ATA_CBL_PATA80;
-}
-
-static void jmicron_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-}
-
-/**
- *	jmicron_set_dma_mode	-	set host controller for DMA mode
- *	@hwif: port
- *	@drive: drive
- *
- *	As the JMicron snoops for timings we don't need to do anything here.
- */
-
-static void jmicron_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-}
-
-static const struct ide_port_ops jmicron_port_ops = {
-	.set_pio_mode		= jmicron_set_pio_mode,
-	.set_dma_mode		= jmicron_set_dma_mode,
-	.cable_detect		= jmicron_cable_detect,
-};
-
-static const struct ide_port_info jmicron_chipset = {
-	.name		= DRV_NAME,
-	.enablebits	= { { 0x40, 0x01, 0x01 }, { 0x40, 0x10, 0x10 } },
-	.port_ops	= &jmicron_port_ops,
-	.pio_mask	= ATA_PIO5,
-	.mwdma_mask	= ATA_MWDMA2,
-	.udma_mask	= ATA_UDMA6,
-};
-
-/**
- *	jmicron_init_one	-	pci layer discovery entry
- *	@dev: PCI device
- *	@id: ident table entry
- *
- *	Called by the PCI code when it finds a Jmicron controller.
- *	We then use the IDE PCI generic helper to do most of the work.
- */
-
-static int jmicron_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	return ide_pci_init_one(dev, &jmicron_chipset, NULL);
-}
-
-/* All JMB PATA controllers have and will continue to have the same
- * interface.  Matching vendor and device class is enough for all
- * current and future controllers if the controller is programmed
- * properly.
- *
- * If libata is configured, jmicron PCI quirk programs the controller
- * into the correct mode.  If libata isn't configured, match known
- * device IDs too to maintain backward compatibility.
- */
-static struct pci_device_id jmicron_pci_tbl[] = {
-#if !defined(CONFIG_ATA) && !defined(CONFIG_ATA_MODULE)
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB361) },
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB363) },
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB365) },
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB366) },
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB368) },
-#endif
-	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 0 },
-	{ 0, },
-};
-
-MODULE_DEVICE_TABLE(pci, jmicron_pci_tbl);
-
-static struct pci_driver jmicron_pci_driver = {
-	.name		= "JMicron IDE",
-	.id_table	= jmicron_pci_tbl,
-	.probe		= jmicron_init_one,
-	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
-};
-
-static int __init jmicron_ide_init(void)
-{
-	return ide_pci_register_driver(&jmicron_pci_driver);
-}
-
-static void __exit jmicron_ide_exit(void)
-{
-	pci_unregister_driver(&jmicron_pci_driver);
-}
-
-module_init(jmicron_ide_init);
-module_exit(jmicron_ide_exit);
-
-MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("PCI driver module for the JMicron in legacy modes");
-MODULE_LICENSE("GPL");
-- 
1.9.1
