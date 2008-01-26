From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 11/13] sata_mv ncq Enable NCQ operation
Date: Sat, 26 Jan 2008 18:33:18 -0500
Message-ID: <479BC33E.70600@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3077 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbYAZXdT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:33:19 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Final changes to actually turn on NCQ in the driver for GEN_II/IIE hardware.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-26 12:41:01.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-26 12:43:21.000000000 -0500
@@ -510,7 +510,8 @@
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= MV_MAX_Q_DEPTH - 1,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
@@ -572,6 +573,7 @@
 	.post_internal_cmd	= mv_post_int_cmd,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
+	.qc_defer		= ata_std_qc_defer,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
@@ -600,6 +602,7 @@
 	.post_internal_cmd	= mv_post_int_cmd,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
+	.qc_defer		= ata_std_qc_defer,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
@@ -628,26 +631,29 @@
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_604x */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS,
+		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_NCQ,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_608x */
 		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				  MV_FLAG_DUAL_HC,
+				  ATA_FLAG_NCQ | MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_6042 */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS,
+		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_NCQ,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_7042 */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS,
+		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_NCQ,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
@@ -1261,7 +1267,8 @@
 	u16 flags = 0;
 	unsigned in_index;
 
-	if (qc->tf.protocol != ATA_PROT_DMA)
+	if ((qc->tf.protocol != ATA_PROT_DMA) &&
+	    (qc->tf.protocol != ATA_PROT_NCQ))
 		return;
 
 	/* Fill in command request block
@@ -1297,13 +1304,11 @@
 	case ATA_CMD_WRITE_FUA_EXT:
 		mv_crqb_pack_cmd(cw++, tf->hob_nsect, ATA_REG_NSECT, 0);
 		break;
-#ifdef LIBATA_NCQ		/* FIXME: remove this line when NCQ added */
 	case ATA_CMD_FPDMA_READ:
 	case ATA_CMD_FPDMA_WRITE:
 		mv_crqb_pack_cmd(cw++, tf->hob_feature, ATA_REG_FEATURE, 0);
 		mv_crqb_pack_cmd(cw++, tf->feature, ATA_REG_FEATURE, 0);
 		break;
-#endif				/* FIXME: remove this line when NCQ added */
 	default:
 		/* The only other commands EDMA supports in non-queued and
 		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
@@ -1352,7 +1357,8 @@
 	unsigned in_index;
 	u32 flags = 0;
 
-	if (qc->tf.protocol != ATA_PROT_DMA)
+	if ((qc->tf.protocol != ATA_PROT_DMA) &&
+	    (qc->tf.protocol != ATA_PROT_NCQ))
 		return;
 
 	/* Fill in Gen IIE command request block
@@ -1418,7 +1424,8 @@
 	struct mv_port_priv *pp = ap->private_data;
 	u32 in_index;
 
-	if (qc->tf.protocol != ATA_PROT_DMA) {
+	if ((qc->tf.protocol != ATA_PROT_DMA) &&
+	    (qc->tf.protocol != ATA_PROT_NCQ)) {
 		/* We're about to send a non-EDMA capable command to the
 		 * port.  Turn off EDMA so there won't be problems accessing
 		 * shadow block, etc registers.
@@ -1429,12 +1436,6 @@
 
 	mv_start_dma(ap, port_mmio, pp, qc->tf.protocol);
 
-	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
-
-	/* until we do queuing, the queue should be empty at this point */
-	WARN_ON(in_index != ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
-		>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
-
 	pp->req_idx++;
 
 	in_index = (pp->req_idx & MV_MAX_Q_DEPTH_MASK) << EDMA_REQ_Q_PTR_SHIFT;
