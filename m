From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/10] ide: add ->chipset field to ide_pci_device_t
Date: Tue, 11 Sep 2007 23:39:34 +0200
Message-ID: <200709112339.34991.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:27120 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120AbXIKVkY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:24 -0400
Received: by ug-out-1314.google.com with SMTP id z38so138055ugc
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add ->chipset field to ide_pci_device_t and use it in ide_hwif_configure()
to set hwif->chipset.  Convert cmd64x, cy82c693, rz1000 and trm290 host
drivers to use this new ability.

While at it define hwif_chipset_t as u8 to save some space in hw_regs_t,
ide_hwif_t and ide_pci_device_t instances.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd64x.c   |    4 +---
 drivers/ide/pci/cy82c693.c |    2 +-
 drivers/ide/pci/rz1000.c   |    2 +-
 drivers/ide/pci/trm290.c   |    2 +-
 drivers/ide/setup-pci.c    |    2 +-
 include/linux/ide.h        |    7 +++++--
 6 files changed, 10 insertions(+), 9 deletions(-)

Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -506,9 +506,6 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->set_pio_mode = &cmd64x_set_pio_mode;
 	hwif->set_dma_mode = &cmd64x_set_dma_mode;
 
-	if (dev->device == PCI_DEVICE_ID_CMD_646)
-		hwif->chipset = ide_cmd646;
-
 	if (!hwif->dma_base)
 		return;
 
@@ -575,6 +572,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
+		.chipset	= ide_cmd646,
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH | IDE_HFLAG_BOOTABLE,
 		.pio_mask	= ATA_PIO5,
 		.mwdma_mask	= ATA_MWDMA2,
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -428,7 +428,6 @@ static unsigned int __devinit init_chips
  */
 static void __devinit init_hwif_cy82c693(ide_hwif_t *hwif)
 {
-	hwif->chipset = ide_cy82c693;
 	hwif->set_pio_mode = &cy82c693_set_pio_mode;
 
 	if (hwif->dma_base == 0)
@@ -454,6 +453,7 @@ static ide_pci_device_t cy82c693_chipset
 	.init_chipset	= init_chipset_cy82c693,
 	.init_iops	= init_iops_cy82c693,
 	.init_hwif	= init_hwif_cy82c693,
+	.chipset	= ide_cy82c693,
 	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
Index: b/drivers/ide/pci/rz1000.c
===================================================================
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -35,7 +35,6 @@ static void __devinit init_hwif_rz1000 (
 	u16 reg;
 	struct pci_dev *dev = hwif->pci_dev;
 
-	hwif->chipset = ide_rz1000;
 	if (!pci_read_config_word (dev, 0x40, &reg) &&
 	    !pci_write_config_word(dev, 0x40, reg & 0xdfff)) {
 		printk(KERN_INFO "%s: disabled chipset read-ahead "
@@ -53,6 +52,7 @@ static void __devinit init_hwif_rz1000 (
 static ide_pci_device_t rz1000_chipset __devinitdata = {
 	.name		= "RZ100x",
 	.init_hwif	= init_hwif_rz1000,
+	.chipset	= ide_rz1000,
 	.host_flags	= IDE_HFLAG_NO_DMA | IDE_HFLAG_BOOTABLE,
 };
 
Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -250,7 +250,6 @@ static void __devinit init_hwif_trm290(i
 	u8 reg = 0;
 	struct pci_dev *dev = hwif->pci_dev;
 
-	hwif->chipset = ide_trm290;
 	cfgbase = pci_resource_start(dev, 4);
 	if ((dev->class & 5) && cfgbase) {
 		hwif->config_data = cfgbase;
@@ -323,6 +322,7 @@ static void __devinit init_hwif_trm290(i
 static ide_pci_device_t trm290_chipset __devinitdata = {
 	.name		= "TRM290",
 	.init_hwif	= init_hwif_trm290,
+	.chipset	= ide_trm290,
 	.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
 #if 0 /* play it safe for now */
 			  IDE_HFLAG_TRUST_BIOS_FOR_DMA |
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -397,7 +397,7 @@ static ide_hwif_t *ide_hwif_configure(st
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 	}
-	hwif->chipset = ide_pci;
+	hwif->chipset = d->chipset ? d->chipset : ide_pci;
 	hwif->pci_dev = dev;
 	hwif->cds = (struct ide_pci_device_s *) d;
 	hwif->channel = port;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -200,14 +200,16 @@ typedef int (ide_ack_intr_t)(struct hwif
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
  */
-typedef enum {	ide_unknown,	ide_generic,	ide_pci,
+enum {		ide_unknown,	ide_generic,	ide_pci,
 		ide_cmd640,	ide_dtc2278,	ide_ali14xx,
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
 		ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
 		ide_au1xxx, ide_forced
-} hwif_chipset_t;
+};
+
+typedef u8 hwif_chipset_t;
 
 /*
  * Structure to hold all information about the location of this port
@@ -1282,6 +1284,7 @@ typedef struct ide_pci_device_s {
 	void			(*init_dma)(ide_hwif_t *, unsigned long);
 	void			(*fixup)(ide_hwif_t *);
 	ide_pci_enablebit_t	enablebits[2];
+	hwif_chipset_t		chipset;
 	unsigned int		extra;
 	u32			host_flags;
 	u8			pio_mask;
