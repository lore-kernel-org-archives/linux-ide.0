From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 1/1] [LibATA] sata_mv: Remove dumplicated host template
Date: Sun, 16 Dec 2007 16:11:56 +0200
Message-ID: <11978143164051-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:40342 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753960AbXLPOMI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Dec 2007 09:12:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: saeed.bishara@gmail.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@marvell.com>

The mv5_sht and mv6_sht structures are identical. This patch removes one of
those structures and renames the other to mv_sht.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 8d864e5..4076194 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -452,25 +452,7 @@ static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio);
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
 
-static struct scsi_host_template mv5_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= MV_MAX_SG_CT / 2,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= 1,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= MV_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
-};
-
-static struct scsi_host_template mv6_sht = {
+static struct scsi_host_template mv_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
@@ -2740,7 +2722,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 	return ata_host_activate(host, pdev->irq, mv_interrupt, IRQF_SHARED,
-				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);
+				 &mv_sht);
 }
 
 static int __init mv_init(void)
-- 
1.5.0.6

