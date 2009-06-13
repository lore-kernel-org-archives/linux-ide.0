From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/10] cmd64x: implement clear_irq() method (take 2)
Date: Sat, 13 Jun 2009 17:30:41 +0400
Message-ID: <200906131730.41803.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52406 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932373AbZFMN3B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 09:29:01 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Convert the driver's two dma_end() methods into clear_irq() methods -- the
driver will now use the standard dma_end() method implementation, ide_dma_end().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

Changes since previous take:
- fixed cmd648_clear_irq() to use pci_resource_start() ISO hwif->dma_base.

 drivers/ide/cmd64x.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

Index: ide-2.6/drivers/ide/cmd64x.c
===================================================================
--- ide-2.6.orig/drivers/ide/cmd64x.c
+++ ide-2.6/drivers/ide/cmd64x.c
@@ -7,7 +7,7 @@
  * Copyright (C) 1998		David S. Miller (davem@redhat.com)
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
- * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
+ * Copyright (C) 2007,2009	MontaVista Software, Inc. <source@mvista.com>
  */
 
 #include <linux/module.h>
@@ -226,11 +226,11 @@ static void cmd64x_set_dma_mode(ide_driv
 		(void) pci_write_config_byte(dev, pciU, regU);
 }
 
-static int cmd648_dma_end(ide_drive_t *drive)
+static void cmd648_clear_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= drive->hwif;
-	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
-	int err			= ide_dma_end(drive);
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	unsigned long base	= pci_resource_start(dev, 4);
 	u8  irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
 						  MRDMODE_INTR_CH0;
 	u8  mrdmode		= inb(base + 1);
@@ -238,11 +238,9 @@ static int cmd648_dma_end(ide_drive_t *d
 	/* clear the interrupt bit */
 	outb((mrdmode & ~(MRDMODE_INTR_CH0 | MRDMODE_INTR_CH1)) | irq_mask,
 	     base + 1);
-
-	return err;
 }
 
-static int cmd64x_dma_end(ide_drive_t *drive)
+static void cmd64x_clear_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
@@ -250,13 +248,10 @@ static int cmd64x_dma_end(ide_drive_t *d
 	u8  irq_mask		= hwif->channel ? ARTTIM23_INTR_CH1 :
 						  CFR_INTR_CH0;
 	u8  irq_stat		= 0;
-	int err			= ide_dma_end(drive);
 
 	(void) pci_read_config_byte(dev, irq_reg, &irq_stat);
 	/* clear the interrupt bit */
 	(void) pci_write_config_byte(dev, irq_reg, irq_stat | irq_mask);
-
-	return err;
 }
 
 static int cmd648_dma_test_irq(ide_drive_t *drive)
@@ -370,6 +365,14 @@ static u8 cmd64x_cable_detect(ide_hwif_t
 static const struct ide_port_ops cmd64x_port_ops = {
 	.set_pio_mode		= cmd64x_set_pio_mode,
 	.set_dma_mode		= cmd64x_set_dma_mode,
+	.clear_irq		= cmd64x_clear_irq,
+	.cable_detect		= cmd64x_cable_detect,
+};
+
+static const struct ide_port_ops cmd648_port_ops = {
+	.set_pio_mode		= cmd64x_set_pio_mode,
+	.set_dma_mode		= cmd64x_set_dma_mode,
+	.clear_irq		= cmd648_clear_irq,
 	.cable_detect		= cmd64x_cable_detect,
 };
 
@@ -377,7 +380,7 @@ static const struct ide_dma_ops cmd64x_d
 	.dma_host_set		= ide_dma_host_set,
 	.dma_setup		= ide_dma_setup,
 	.dma_start		= ide_dma_start,
-	.dma_end		= cmd64x_dma_end,
+	.dma_end		= ide_dma_end,
 	.dma_test_irq		= cmd64x_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timer_expiry	= ide_dma_sff_timer_expiry,
@@ -399,7 +402,7 @@ static const struct ide_dma_ops cmd648_d
 	.dma_host_set		= ide_dma_host_set,
 	.dma_setup		= ide_dma_setup,
 	.dma_start		= ide_dma_start,
-	.dma_end		= cmd648_dma_end,
+	.dma_end		= ide_dma_end,
 	.dma_test_irq		= cmd648_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timer_expiry	= ide_dma_sff_timer_expiry,
@@ -423,7 +426,7 @@ static const struct ide_port_info cmd64x
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
-		.port_ops	= &cmd64x_port_ops,
+		.port_ops	= &cmd648_port_ops,
 		.dma_ops	= &cmd648_dma_ops,
 		.host_flags	= IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_ABUSE_PREFETCH,
@@ -435,7 +438,7 @@ static const struct ide_port_info cmd64x
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
-		.port_ops	= &cmd64x_port_ops,
+		.port_ops	= &cmd648_port_ops,
 		.dma_ops	= &cmd648_dma_ops,
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
@@ -446,7 +449,7 @@ static const struct ide_port_info cmd64x
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
-		.port_ops	= &cmd64x_port_ops,
+		.port_ops	= &cmd648_port_ops,
 		.dma_ops	= &cmd648_dma_ops,
 		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
@@ -484,6 +487,7 @@ static int __devinit cmd64x_init_one(str
 			 */
 			if (dev->revision < 3) {
 				d.enablebits[0].reg = 0;
+				d.port_ops = &cmd64x_port_ops;
 				if (dev->revision == 1)
 					d.dma_ops = &cmd646_rev1_dma_ops;
 				else

