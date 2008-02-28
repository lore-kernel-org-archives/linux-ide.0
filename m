From: "Anantha Subramanyam" <ananth@broadcom.com>
Subject: [PATCH 2.6.23.11] sata_svw: Add support for HT1100 SATA
 controller
Date: Thu, 28 Feb 2008 15:58:35 -0800
Message-ID: <1204243115.4504.25.camel@LTSJCW-ANANTH.sj.broadcom.com>
Reply-To: ananth@broadcom.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:1050 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbYB1X67 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 18:58:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

This patch adds support (including ATAPI DMA) for HT1100 (aka BCM11000) SATA controller.

Signed-off-by: Anantha Subramanyam <ananth@broadcom.com>
---
--- l2311/drivers/ata/sata_svw.c.orig	2008-01-07 05:22:29.000000000 -0800
+++ l2311/drivers/ata/sata_svw.c	2008-02-28 03:18:07.000000000 -0800
@@ -45,6 +45,8 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi.h>
 #include <linux/libata.h>
 
 #ifdef CONFIG_PPC_OF
@@ -59,6 +61,7 @@ enum {
 	/* ap->flags bits */
 	K2_FLAG_SATA_8_PORTS		= (1 << 24),
 	K2_FLAG_NO_ATAPI_DMA		= (1 << 25),
+	K2_FLAG_BAR_POS_3			= (1 << 26),
 
 	/* Taskfile registers offsets */
 	K2_SATA_TF_CMD_OFFSET		= 0x00,
@@ -88,8 +91,10 @@ enum {
 	/* Port stride */
 	K2_SATA_PORT_OFFSET		= 0x100,
 
-	board_svw4			= 0,
-	board_svw8			= 1,
+	chip_svw4			= 0,
+	chip_svw8			= 1,
+	chip_svw42			= 2,	/* bar 3 */
+	chip_svw43			= 3,	/* bar 5 */
 };
 
 static u8 k2_stat_check_status(struct ata_port *ap);
@@ -97,10 +102,25 @@ static u8 k2_stat_check_status(struct at
 
 static int k2_sata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
+	u8 cmnd = qc->scsicmd->cmnd[0];
+
 	if (qc->ap->flags & K2_FLAG_NO_ATAPI_DMA)
 		return -1;	/* ATAPI DMA not supported */
+	else {
+		switch (cmnd) {
+		case READ_10:
+		case READ_12:
+		case READ_16:
+		case WRITE_10:
+		case WRITE_12:
+		case WRITE_16:
+			return 0;
+
+		default:
+			return -1;
+		}
 
-	return 0;
+	}
 }
 
 static int k2_sata_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
@@ -356,7 +376,7 @@ static const struct ata_port_operations 
 };
 
 static const struct ata_port_info k2_port_info[] = {
-	/* board_svw4 */
+	/* chip_svw4 */
 	{
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA,
@@ -365,7 +385,7 @@ static const struct ata_port_info k2_por
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &k2_sata_ops,
 	},
-	/* board_svw8 */
+	/* chip_svw8 */
 	{
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA |
@@ -375,6 +395,24 @@ static const struct ata_port_info k2_por
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &k2_sata_ops,
 	},
+	/* chip_svw42 */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | K2_FLAG_BAR_POS_3,
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &k2_sata_ops,
+	},
+	/* chip_svw43 */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO,
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &k2_sata_ops,
+	},
 };
 
 static void k2_sata_setup_port(struct ata_ioports *port, void __iomem *base)
@@ -404,7 +442,7 @@ static int k2_sata_init_one (struct pci_
 		{ &k2_port_info[ent->driver_data], NULL };
 	struct ata_host *host;
 	void __iomem *mmio_base;
-	int n_ports, i, rc;
+	int n_ports, i, rc, bar_pos;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -418,6 +456,9 @@ static int k2_sata_init_one (struct pci_
 	if (!host)
 		return -ENOMEM;
 
+	bar_pos = 5;
+	if (ppi[0]->flags & K2_FLAG_BAR_POS_3)
+		bar_pos = 3;
 	/*
 	 * If this driver happens to only be useful on Apple's K2, then
 	 * we should check that here as it has a normal Serverworks ID
@@ -430,17 +471,23 @@ static int k2_sata_init_one (struct pci_
 	 * Check if we have resources mapped at all (second function may
 	 * have been disabled by firmware)
 	 */
-	if (pci_resource_len(pdev, 5) == 0)
+	if (pci_resource_len(pdev, bar_pos) == 0) {
+		/* In IDE mode we need to pin the device to ensure that
+			pcim_release does not clear the busmaster bit in config
+			space, clearing causes busmaster DMA to fail on
+			ports 3 & 4 */
+		pcim_pin_device(pdev);
 		return -ENODEV;
+	}
 
 	/* Request and iomap PCI regions */
-	rc = pcim_iomap_regions(pdev, 1 << 5, DRV_NAME);
+	rc = pcim_iomap_regions(pdev, 1 << bar_pos, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
-	mmio_base = host->iomap[5];
+	mmio_base = host->iomap[bar_pos];
 
 	/* different controllers have different number of ports - currently 4 or 8 */
 	/* All ports are on the same function. Multi-function device is no
@@ -479,11 +526,13 @@ static int k2_sata_init_one (struct pci_
  * controller
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
-	{ PCI_VDEVICE(SERVERWORKS, 0x0240), board_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0241), board_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0242), board_svw8 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024a), board_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024b), board_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw8 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0410), chip_svw42 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0411), chip_svw43 },
 
 	{ }
 };




