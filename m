From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/9] icside: use ec->dma directly
Date: Mon, 24 Sep 2007 22:36:11 +0200
Message-ID: <200709242236.11916.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29636 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbXIXUqH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:07 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485942nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>


* hwif->hwif_data contains pointer to struct expansion_card so use ec->dma
  directly instead of caching it in hwif->hw.dma.

* Remove no longer needed hw_regs_t.dma and NO_DMA define.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c          |   20 ++++++++++----------
 drivers/ide/h8300/ide-h8300.c     |    1 -
 drivers/ide/ide-pnp.c             |    1 -
 drivers/ide/ide.c                 |    1 -
 drivers/ide/legacy/ide_platform.c |    1 -
 drivers/ide/legacy/q40ide.c       |    3 +--
 include/linux/ide.h               |    5 -----
 7 files changed, 11 insertions(+), 21 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -316,27 +316,29 @@ static int icside_dma_end(ide_drive_t *d
 
 	drive->waiting_for_dma = 0;
 
-	disable_dma(hwif->hw.dma);
+	disable_dma(state->dev->dma);
 
 	/* Teardown mappings after DMA has completed. */
 	dma_unmap_sg(state->dev, hwif->sg_table, hwif->sg_nents,
 		     hwif->sg_dma_direction);
 
-	return get_dma_residue(hwif->hw.dma) != 0;
+	return get_dma_residue(state->dev->dma) != 0;
 }
 
 static void icside_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	struct icside_state *state = hwif->hwif_data;
 
 	/* We can not enable DMA on both channels simultaneously. */
-	BUG_ON(dma_channel_active(hwif->hw.dma));
-	enable_dma(hwif->hw.dma);
+	BUG_ON(dma_channel_active(state->dev->dma));
+	enable_dma(state->dev->dma);
 }
 
 static int icside_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	struct icside_state *state = hwif->hwif_data;
 	struct request *rq = hwif->hwgroup->rq;
 	unsigned int dma_mode;
 
@@ -348,7 +350,7 @@ static int icside_dma_setup(ide_drive_t 
 	/*
 	 * We can not enable DMA on both channels.
 	 */
-	BUG_ON(dma_channel_active(hwif->hw.dma));
+	BUG_ON(dma_channel_active(state->dev->dma));
 
 	icside_build_sglist(drive, rq);
 
@@ -365,14 +367,14 @@ static int icside_dma_setup(ide_drive_t 
 	/*
 	 * Select the correct timing for this drive.
 	 */
-	set_dma_speed(hwif->hw.dma, drive->drive_data);
+	set_dma_speed(state->dev->dma, drive->drive_data);
 
 	/*
 	 * Tell the DMA engine about the SG table and
 	 * data direction.
 	 */
-	set_dma_sg(hwif->hw.dma, hwif->sg_table, hwif->sg_nents);
-	set_dma_mode(hwif->hw.dma, dma_mode);
+	set_dma_sg(state->dev->dma, hwif->sg_table, hwif->sg_nents);
+	set_dma_mode(state->dev->dma, dma_mode);
 
 	drive->waiting_for_dma = 1;
 
@@ -572,7 +574,6 @@ icside_register_v6(struct icside_state *
 	hwif->serialized  = 1;
 	hwif->config_data = (unsigned long)ioc_base;
 	hwif->select_data = sel;
-	hwif->hw.dma      = ec->dma;
 
 	mate->maskproc    = icside_maskproc;
 	mate->channel     = 1;
@@ -581,7 +582,6 @@ icside_register_v6(struct icside_state *
 	mate->serialized  = 1;
 	mate->config_data = (unsigned long)ioc_base;
 	mate->select_data = sel | 1;
-	mate->hw.dma      = ec->dma;
 
 	if (ec->dma != NO_DMA && !request_dma(ec->dma, hwif->name)) {
 		icside_dma_init(hwif);
Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -68,7 +68,6 @@ static inline void hw_setup(hw_regs_t *h
 		hw->io_ports[i] = CONFIG_H8300_IDE_BASE + H8300_IDE_GAP*i;
 	hw->io_ports[IDE_CONTROL_OFFSET] = CONFIG_H8300_IDE_ALT;
 	hw->irq = EXT_IRQ0 + CONFIG_H8300_IDE_IRQ;
-	hw->dma = NO_DMA;
 	hw->chipset = ide_generic;
 }
 
Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -40,7 +40,6 @@ static int idepnp_probe(struct pnp_dev *
 	ide_std_init_ports(&hw, pnp_port_start(dev, 0),
 				pnp_port_start(dev, 1));
 	hw.irq = pnp_irq(dev, 0);
-	hw.dma = NO_DMA;
 
 	index = ide_register_hw(&hw, NULL, 1, &hwif);
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -680,7 +680,6 @@ void ide_setup_ports (	hw_regs_t *hw,
 		}
 	}
 	hw->irq = irq;
-	hw->dma = NO_DMA;
 	hw->ack_intr = ack_intr;
 /*
  *	hw->iops = iops;
Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -51,7 +51,6 @@ static ide_hwif_t *__devinit plat_ide_lo
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 	hwif->hw.irq = hwif->irq = irq;
 
-	hwif->hw.dma = NO_DMA;
 	hwif->chipset = hwif->hw.chipset = ide_generic;
 
 	if (mmio) {
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -89,9 +89,8 @@ void q40_ide_setup_ports ( hw_regs_t *hw
 		else
 			hw->io_ports[i] = Q40_ISA_IO_B(base + offsets[i]);
 	}
-	
+
 	hw->irq = irq;
-	hw->dma = NO_DMA;
 	hw->ack_intr = ack_intr;
 /*
  *	hw->iops = iops;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -192,10 +192,6 @@ typedef unsigned char	byte;	/* used ever
 struct hwif_s;
 typedef int (ide_ack_intr_t)(struct hwif_s *);
 
-#ifndef NO_DMA
-#define NO_DMA  255
-#endif
-
 /*
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
@@ -217,7 +213,6 @@ typedef u8 hwif_chipset_t;
 typedef struct hw_regs_s {
 	unsigned long	io_ports[IDE_NR_PORTS];	/* task file registers */
 	int		irq;			/* our irq number */
-	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	hwif_chipset_t  chipset;
 	struct device	*dev;
