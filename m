From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 16/19] ide: remove deprecated slc90e66 host driver
Date: Thu, 04 Feb 2016 14:44:13 +0100
Message-ID: <1454593456-3162-17-git-send-email-b.zolnierkie@samsung.com>
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

The replacement driver (pata_efar) has been available since
2006 and it supports all the hardware supported by the old
slc90e66 host driver.

Remove the deprecated slc90e66 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig    |  13 ----
 drivers/ide/Makefile   |   1 -
 drivers/ide/slc90e66.c | 181 -------------------------------------------------
 3 files changed, 195 deletions(-)
 delete mode 100644 drivers/ide/slc90e66.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index d086f52..c92d5d1 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -454,19 +454,6 @@ config BLK_DEV_SL82C105
 	  special configuration for this chip. This is common on various CHRP
 	  motherboards, but could be used elsewhere. If in doubt, say Y.
 
-config BLK_DEV_SLC90E66
-	tristate "SLC90E66 chipset support"
-	select BLK_DEV_IDEDMA_PCI
-	help
-	  This driver ensures (U)DMA support for Victory66 SouthBridges for
-	  SMsC with Intel NorthBridges.  This is an Ultra66 based chipset.
-	  The nice thing about it is that you can mix Ultra/DMA/PIO devices
-	  and it will handle timing cycles.  Since this is an improved
-	  look-a-like to the PIIX4 it should be a nice addition.
-
-	  Please read the comments at the top of
-	  <file:drivers/ide/slc90e66.c>.
-
 config BLK_DEV_TRM290
 	tristate "Tekram TRM290 chipset support"
 	select BLK_DEV_IDEDMA_PCI
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 3867f7d..1ff2f8a 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -47,7 +47,6 @@ obj-$(CONFIG_BLK_DEV_PIIX)		+= piix.o
 obj-$(CONFIG_BLK_DEV_SGIIOC4)		+= sgiioc4.o
 obj-$(CONFIG_BLK_DEV_SIIMAGE)		+= siimage.o
 obj-$(CONFIG_BLK_DEV_SL82C105)		+= sl82c105.o
-obj-$(CONFIG_BLK_DEV_SLC90E66)		+= slc90e66.o
 obj-$(CONFIG_BLK_DEV_TC86C001)		+= tc86c001.o
 obj-$(CONFIG_BLK_DEV_TRIFLEX)		+= triflex.o
 obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
diff --git a/drivers/ide/slc90e66.c b/drivers/ide/slc90e66.c
deleted file mode 100644
index 8af92bb..0000000
--- a/drivers/ide/slc90e66.c
+++ /dev/null
@@ -1,181 +0,0 @@
-/*
- *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
- *
- * This is a look-alike variation of the ICH0 PIIX4 Ultra-66,
- * but this keeps the ISA-Bridge and slots alive.
- *
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#define DRV_NAME "slc90e66"
-
-static DEFINE_SPINLOCK(slc90e66_lock);
-
-static void slc90e66_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	int is_slave		= drive->dn & 1;
-	int master_port		= hwif->channel ? 0x42 : 0x40;
-	int slave_port		= 0x44;
-	unsigned long flags;
-	u16 master_data;
-	u8 slave_data;
-	int control = 0;
-	const u8 pio = drive->pio_mode - XFER_PIO_0;
-
-				     /* ISP  RTC */
-	static const u8 timings[][2] = {
-					{ 0, 0 },
-					{ 0, 0 },
-					{ 1, 0 },
-					{ 2, 1 },
-					{ 2, 3 }, };
-
-	spin_lock_irqsave(&slc90e66_lock, flags);
-	pci_read_config_word(dev, master_port, &master_data);
-
-	if (pio > 1)
-		control |= 1;	/* Programmable timing on */
-	if (drive->media == ide_disk)
-		control |= 4;	/* Prefetch, post write */
-	if (ide_pio_need_iordy(drive, pio))
-		control |= 2;	/* IORDY */
-	if (is_slave) {
-		master_data |=  0x4000;
-		master_data &= ~0x0070;
-		if (pio > 1) {
-			/* Set PPE, IE and TIME */
-			master_data |= control << 4;
-		}
-		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data &= hwif->channel ? 0x0f : 0xf0;
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) <<
-			       (hwif->channel ? 4 : 0);
-	} else {
-		master_data &= ~0x3307;
-		if (pio > 1) {
-			/* enable PPE, IE and TIME */
-			master_data |= control;
-		}
-		master_data |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
-	}
-	pci_write_config_word(dev, master_port, master_data);
-	if (is_slave)
-		pci_write_config_byte(dev, slave_port, slave_data);
-	spin_unlock_irqrestore(&slc90e66_lock, flags);
-}
-
-static void slc90e66_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	u8 maslave		= hwif->channel ? 0x42 : 0x40;
-	int sitre = 0, a_speed	= 7 << (drive->dn * 4);
-	int u_speed = 0, u_flag = 1 << drive->dn;
-	u16			reg4042, reg44, reg48, reg4a;
-	const u8 speed		= drive->dma_mode;
-
-	pci_read_config_word(dev, maslave, &reg4042);
-	sitre = (reg4042 & 0x4000) ? 1 : 0;
-	pci_read_config_word(dev, 0x44, &reg44);
-	pci_read_config_word(dev, 0x48, &reg48);
-	pci_read_config_word(dev, 0x4a, &reg4a);
-
-	if (speed >= XFER_UDMA_0) {
-		u_speed = (speed - XFER_UDMA_0) << (drive->dn * 4);
-
-		if (!(reg48 & u_flag))
-			pci_write_config_word(dev, 0x48, reg48|u_flag);
-		if ((reg4a & a_speed) != u_speed) {
-			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-			pci_read_config_word(dev, 0x4a, &reg4a);
-			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
-		}
-	} else {
-		const u8 mwdma_to_pio[] = { 0, 3, 4 };
-
-		if (reg48 & u_flag)
-			pci_write_config_word(dev, 0x48, reg48 & ~u_flag);
-		if (reg4a & a_speed)
-			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-
-		if (speed >= XFER_MW_DMA_0)
-			drive->pio_mode =
-				mwdma_to_pio[speed - XFER_MW_DMA_0] + XFER_PIO_0;
-		else
-			drive->pio_mode = XFER_PIO_2; /* for SWDMA2 */
-
-		slc90e66_set_pio_mode(hwif, drive);
-	}
-}
-
-static u8 slc90e66_cable_detect(ide_hwif_t *hwif)
-{
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	u8 reg47 = 0, mask = hwif->channel ? 0x01 : 0x02;
-
-	pci_read_config_byte(dev, 0x47, &reg47);
-
-	/* bit[0(1)]: 0:80, 1:40 */
-	return (reg47 & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
-}
-
-static const struct ide_port_ops slc90e66_port_ops = {
-	.set_pio_mode		= slc90e66_set_pio_mode,
-	.set_dma_mode		= slc90e66_set_dma_mode,
-	.cable_detect		= slc90e66_cable_detect,
-};
-
-static const struct ide_port_info slc90e66_chipset = {
-	.name		= DRV_NAME,
-	.enablebits	= { {0x41, 0x80, 0x80}, {0x43, 0x80, 0x80} },
-	.port_ops	= &slc90e66_port_ops,
-	.pio_mask	= ATA_PIO4,
-	.swdma_mask	= ATA_SWDMA2_ONLY,
-	.mwdma_mask	= ATA_MWDMA12_ONLY,
-	.udma_mask	= ATA_UDMA4,
-};
-
-static int slc90e66_init_one(struct pci_dev *dev,
-			     const struct pci_device_id *id)
-{
-	return ide_pci_init_one(dev, &slc90e66_chipset, NULL);
-}
-
-static const struct pci_device_id slc90e66_pci_tbl[] = {
-	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1), 0 },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE(pci, slc90e66_pci_tbl);
-
-static struct pci_driver slc90e66_pci_driver = {
-	.name		= "SLC90e66_IDE",
-	.id_table	= slc90e66_pci_tbl,
-	.probe		= slc90e66_init_one,
-	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
-};
-
-static int __init slc90e66_ide_init(void)
-{
-	return ide_pci_register_driver(&slc90e66_pci_driver);
-}
-
-static void __exit slc90e66_ide_exit(void)
-{
-	pci_unregister_driver(&slc90e66_pci_driver);
-}
-
-module_init(slc90e66_ide_init);
-module_exit(slc90e66_ide_exit);
-
-MODULE_AUTHOR("Andre Hedrick");
-MODULE_DESCRIPTION("PCI driver module for SLC90E66 IDE");
-MODULE_LICENSE("GPL");
-- 
1.9.1
