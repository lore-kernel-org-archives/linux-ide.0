From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 7/10] cmd64x: implement test_irq() method
Date: Sat, 13 Jun 2009 17:35:12 +0400
Message-ID: <200906131735.12480.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52441 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753848AbZFMNdb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 09:33:31 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Convert the driver's two dma_test_irq() methods into test_irq() methods. The
driver will now use the standard dma_test_irq() method implementation which
allows to remove 'cmd54x_dma_ops' and 'cmd648_dma_ops' that become identical
to 'sff_dma_ops'...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

 drivers/ide/cmd64x.c |   69 ++++++++-------------------------------------------
 1 files changed, 12 insertions(+), 57 deletions(-)

Index: ide-2.6/drivers/ide/cmd64x.c
===================================================================
--- ide-2.6.orig/drivers/ide/cmd64x.c
+++ ide-2.6/drivers/ide/cmd64x.c
@@ -253,53 +253,34 @@ static void cmd64x_clear_irq(ide_drive_t
 	(void) pci_write_config_byte(dev, irq_reg, irq_stat | irq_mask);
 }
 
-static int cmd648_dma_test_irq(ide_drive_t *drive)
+static int cmd648_test_irq(ide_hwif_t *hwif)
 {
-	ide_hwif_t *hwif	= drive->hwif;
-	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	unsigned long base	= pci_resource_start(dev, 4);
 	u8 irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
 						  MRDMODE_INTR_CH0;
-	u8 dma_stat		= inb(hwif->dma_base + ATA_DMA_STATUS);
 	u8 mrdmode		= inb(base + 1);
 
-#ifdef DEBUG
-	printk("%s: dma_stat: 0x%02x mrdmode: 0x%02x irq_mask: 0x%02x\n",
-	       drive->name, dma_stat, mrdmode, irq_mask);
-#endif
-	if (!(mrdmode & irq_mask))
-		return 0;
-
-	/* return 1 if INTR asserted */
-	if (dma_stat & 4)
-		return 1;
+	pr_debug("%s: mrdmode: 0x%02x irq_mask: 0x%02x\n",
+		 hwif->name, mrdmode, irq_mask);
 
-	return 0;
+	return (mrdmode & irq_mask) ? 1 : 0;
 }
 
-static int cmd64x_dma_test_irq(ide_drive_t *drive)
+static int cmd64x_test_irq(ide_hwif_t *hwif)
 {
-	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	int irq_reg		= hwif->channel ? ARTTIM23 : CFR;
 	u8  irq_mask		= hwif->channel ? ARTTIM23_INTR_CH1 :
 						  CFR_INTR_CH0;
-	u8  dma_stat		= inb(hwif->dma_base + ATA_DMA_STATUS);
 	u8  irq_stat		= 0;
 
 	(void) pci_read_config_byte(dev, irq_reg, &irq_stat);
 
-#ifdef DEBUG
-	printk("%s: dma_stat: 0x%02x irq_stat: 0x%02x irq_mask: 0x%02x\n",
-	       drive->name, dma_stat, irq_stat, irq_mask);
-#endif
-	if (!(irq_stat & irq_mask))
-		return 0;
-
-	/* return 1 if INTR asserted */
-	if (dma_stat & 4)
-		return 1;
+	pr_debug("%s: irq_stat: 0x%02x irq_mask: 0x%02x\n",
+		 hwif->name, irq_stat, irq_mask);
 
-	return 0;
+	return (irq_stat & irq_mask) ? 1 : 0;
 }
 
 /*
@@ -365,6 +346,7 @@ static const struct ide_port_ops cmd64x_
 	.set_pio_mode		= cmd64x_set_pio_mode,
 	.set_dma_mode		= cmd64x_set_dma_mode,
 	.clear_irq		= cmd64x_clear_irq,
+	.test_irq		= cmd64x_test_irq,
 	.cable_detect		= cmd64x_cable_detect,
 };
 
@@ -372,20 +354,10 @@ static const struct ide_port_ops cmd648_
 	.set_pio_mode		= cmd64x_set_pio_mode,
 	.set_dma_mode		= cmd64x_set_dma_mode,
 	.clear_irq		= cmd648_clear_irq,
+	.test_irq		= cmd648_test_irq,
 	.cable_detect		= cmd64x_cable_detect,
 };
 
-static const struct ide_dma_ops cmd64x_dma_ops = {
-	.dma_host_set		= ide_dma_host_set,
-	.dma_setup		= ide_dma_setup,
-	.dma_start		= ide_dma_start,
-	.dma_end		= ide_dma_end,
-	.dma_test_irq		= cmd64x_dma_test_irq,
-	.dma_lost_irq		= ide_dma_lost_irq,
-	.dma_timer_expiry	= ide_dma_sff_timer_expiry,
-	.dma_sff_read_status	= ide_dma_sff_read_status,
-};
-
 static const struct ide_dma_ops cmd646_rev1_dma_ops = {
 	.dma_host_set		= ide_dma_host_set,
 	.dma_setup		= ide_dma_setup,
@@ -397,24 +369,12 @@ static const struct ide_dma_ops cmd646_r
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
-static const struct ide_dma_ops cmd648_dma_ops = {
-	.dma_host_set		= ide_dma_host_set,
-	.dma_setup		= ide_dma_setup,
-	.dma_start		= ide_dma_start,
-	.dma_end		= ide_dma_end,
-	.dma_test_irq		= cmd648_dma_test_irq,
-	.dma_lost_irq		= ide_dma_lost_irq,
-	.dma_timer_expiry	= ide_dma_sff_timer_expiry,
-	.dma_sff_read_status	= ide_dma_sff_read_status,
-};
-
 static const struct ide_port_info cmd64x_chipsets[] __devinitdata = {
 	{	/* 0: CMD643 */
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
 		.port_ops	= &cmd64x_port_ops,
-		.dma_ops	= &cmd64x_dma_ops,
 		.host_flags	= IDE_HFLAG_CLEAR_SIMPLEX |
 				  IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
@@ -426,7 +386,6 @@ static const struct ide_port_info cmd64x
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.port_ops	= &cmd648_port_ops,
-		.dma_ops	= &cmd648_dma_ops,
 		.host_flags	= IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
@@ -438,7 +397,6 @@ static const struct ide_port_info cmd64x
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.port_ops	= &cmd648_port_ops,
-		.dma_ops	= &cmd648_dma_ops,
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.mwdma_mask	= ATA_MWDMA2,
@@ -449,7 +407,6 @@ static const struct ide_port_info cmd64x
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.port_ops	= &cmd648_port_ops,
-		.dma_ops	= &cmd648_dma_ops,
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.mwdma_mask	= ATA_MWDMA2,
@@ -489,8 +446,6 @@ static int __devinit cmd64x_init_one(str
 				d.port_ops = &cmd64x_port_ops;
 				if (dev->revision == 1)
 					d.dma_ops = &cmd646_rev1_dma_ops;
-				else
-					d.dma_ops = &cmd64x_dma_ops;
 			}
 		}
 	}

