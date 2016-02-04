From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 08/19] ide: remove deprecated it8213 host driver
Date: Thu, 04 Feb 2016 14:44:05 +0100
Message-ID: <1454593456-3162-9-git-send-email-b.zolnierkie@samsung.com>
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

The replacement driver (pata_it8213) has been available since
2006 and it supports all the hardware supported by the old
it8213 host driver.

Remove the deprecated it8213 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig  |   6 --
 drivers/ide/Makefile |   1 -
 drivers/ide/it8213.c | 216 ---------------------------------------------------
 3 files changed, 223 deletions(-)
 delete mode 100644 drivers/ide/it8213.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 6c16375..e8e2e6d 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -442,12 +442,6 @@ config BLK_DEV_IT8172
 	  This driver adds support for the IDE controller on the
 	  IT8172 System Controller.
 
-config BLK_DEV_IT8213
-	tristate "IT8213 IDE support"
-	select BLK_DEV_IDEDMA_PCI
-	help
-	 This driver adds support for the ITE 8213 IDE controller.
-
 config BLK_DEV_IT821X
 	tristate "IT821X IDE support"
 	select BLK_DEV_IDEDMA_PCI
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index e582431..03a5398 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 obj-$(CONFIG_BLK_DEV_IT8172)		+= it8172.o
-obj-$(CONFIG_BLK_DEV_IT8213)		+= it8213.o
 obj-$(CONFIG_BLK_DEV_IT821X)		+= it821x.o
 obj-$(CONFIG_BLK_DEV_JMICRON)		+= jmicron.o
 obj-$(CONFIG_BLK_DEV_NS87415)		+= ns87415.o
diff --git a/drivers/ide/it8213.c b/drivers/ide/it8213.c
deleted file mode 100644
index 6b92846..0000000
--- a/drivers/ide/it8213.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * ITE 8213 IDE driver
- *
- * Copyright (C) 2006 Jack Lee
- * Copyright (C) 2006 Alan Cox
- * Copyright (C) 2007 Bartlomiej Zolnierkiewicz
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#define DRV_NAME "it8213"
-
-/**
- *	it8213_set_pio_mode	-	set host controller for PIO mode
- *	@hwif: port
- *	@drive: drive
- *
- *	Set the interface PIO mode.
- */
-
-static void it8213_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	int is_slave		= drive->dn & 1;
-	int master_port		= 0x40;
-	int slave_port		= 0x44;
-	unsigned long flags;
-	u16 master_data;
-	u8 slave_data;
-	static DEFINE_SPINLOCK(tune_lock);
-	int control = 0;
-	const u8 pio = drive->pio_mode - XFER_PIO_0;
-
-	static const u8 timings[][2] = {
-					{ 0, 0 },
-					{ 0, 0 },
-					{ 1, 0 },
-					{ 2, 1 },
-					{ 2, 3 }, };
-
-	spin_lock_irqsave(&tune_lock, flags);
-	pci_read_config_word(dev, master_port, &master_data);
-
-	if (pio > 1)
-		control |= 1;	/* Programmable timing on */
-	if (drive->media != ide_disk)
-		control |= 4;	/* ATAPI */
-	if (ide_pio_need_iordy(drive, pio))
-		control |= 2;	/* IORDY */
-	if (is_slave) {
-		master_data |=  0x4000;
-		master_data &= ~0x0070;
-		if (pio > 1)
-			master_data = master_data | (control << 4);
-		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data = slave_data & 0xf0;
-		slave_data = slave_data | (timings[pio][0] << 2) | timings[pio][1];
-	} else {
-		master_data &= ~0x3307;
-		if (pio > 1)
-			master_data = master_data | control;
-		master_data = master_data | (timings[pio][0] << 12) | (timings[pio][1] << 8);
-	}
-	pci_write_config_word(dev, master_port, master_data);
-	if (is_slave)
-		pci_write_config_byte(dev, slave_port, slave_data);
-	spin_unlock_irqrestore(&tune_lock, flags);
-}
-
-/**
- *	it8213_set_dma_mode	-	set host controller for DMA mode
- *	@hwif: port
- *	@drive: drive
- *
- *	Tune the ITE chipset for the DMA mode.
- */
-
-static void it8213_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	u8 maslave		= 0x40;
-	int a_speed		= 3 << (drive->dn * 4);
-	int u_flag		= 1 << drive->dn;
-	int v_flag		= 0x01 << drive->dn;
-	int w_flag		= 0x10 << drive->dn;
-	int u_speed		= 0;
-	u16			reg4042, reg4a;
-	u8			reg48, reg54, reg55;
-	const u8 speed		= drive->dma_mode;
-
-	pci_read_config_word(dev, maslave, &reg4042);
-	pci_read_config_byte(dev, 0x48, &reg48);
-	pci_read_config_word(dev, 0x4a, &reg4a);
-	pci_read_config_byte(dev, 0x54, &reg54);
-	pci_read_config_byte(dev, 0x55, &reg55);
-
-	if (speed >= XFER_UDMA_0) {
-		u8 udma = speed - XFER_UDMA_0;
-
-		u_speed = min_t(u8, 2 - (udma & 1), udma) << (drive->dn * 4);
-
-		if (!(reg48 & u_flag))
-			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
-		if (speed >= XFER_UDMA_5)
-			pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
-		else
-			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
-
-		if ((reg4a & a_speed) != u_speed)
-			pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
-		if (speed > XFER_UDMA_2) {
-			if (!(reg54 & v_flag))
-				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
-		} else
-			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
-	} else {
-		const u8 mwdma_to_pio[] = { 0, 3, 4 };
-
-		if (reg48 & u_flag)
-			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
-		if (reg4a & a_speed)
-			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-		if (reg54 & v_flag)
-			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
-		if (reg55 & w_flag)
-			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
-
-		if (speed >= XFER_MW_DMA_0)
-			drive->pio_mode =
-				mwdma_to_pio[speed - XFER_MW_DMA_0] + XFER_PIO_0;
-		else
-			drive->pio_mode = XFER_PIO_2; /* for SWDMA2 */
-
-		it8213_set_pio_mode(hwif, drive);
-	}
-}
-
-static u8 it8213_cable_detect(ide_hwif_t *hwif)
-{
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	u8 reg42h = 0;
-
-	pci_read_config_byte(dev, 0x42, &reg42h);
-
-	return (reg42h & 0x02) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
-}
-
-static const struct ide_port_ops it8213_port_ops = {
-	.set_pio_mode		= it8213_set_pio_mode,
-	.set_dma_mode		= it8213_set_dma_mode,
-	.cable_detect		= it8213_cable_detect,
-};
-
-static const struct ide_port_info it8213_chipset = {
-	.name		= DRV_NAME,
-	.enablebits	= { {0x41, 0x80, 0x80} },
-	.port_ops	= &it8213_port_ops,
-	.host_flags	= IDE_HFLAG_SINGLE,
-	.pio_mask	= ATA_PIO4,
-	.swdma_mask	= ATA_SWDMA2_ONLY,
-	.mwdma_mask	= ATA_MWDMA12_ONLY,
-	.udma_mask	= ATA_UDMA6,
-};
-
-/**
- *	it8213_init_one	-	pci layer discovery entry
- *	@dev: PCI device
- *	@id: ident table entry
- *
- *	Called by the PCI code when it finds an ITE8213 controller. As
- *	this device follows the standard interfaces we can use the
- *	standard helper functions to do almost all the work for us.
- */
-
-static int it8213_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	return ide_pci_init_one(dev, &it8213_chipset, NULL);
-}
-
-static const struct pci_device_id it8213_pci_tbl[] = {
-	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8213), 0 },
-	{ 0, },
-};
-
-MODULE_DEVICE_TABLE(pci, it8213_pci_tbl);
-
-static struct pci_driver it8213_pci_driver = {
-	.name		= "ITE8213_IDE",
-	.id_table	= it8213_pci_tbl,
-	.probe		= it8213_init_one,
-	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
-};
-
-static int __init it8213_ide_init(void)
-{
-	return ide_pci_register_driver(&it8213_pci_driver);
-}
-
-static void __exit it8213_ide_exit(void)
-{
-	pci_unregister_driver(&it8213_pci_driver);
-}
-
-module_init(it8213_ide_init);
-module_exit(it8213_ide_exit);
-
-MODULE_AUTHOR("Jack Lee, Alan Cox");
-MODULE_DESCRIPTION("PCI driver module for the ITE 8213");
-MODULE_LICENSE("GPL");
-- 
1.9.1
