From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv: enable ATAPI DMA for GEN_IIE chips
Date: Wed, 04 Feb 2009 13:05:45 -0500
Message-ID: <4989D8F9.2060500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44219 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbZBDSFs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Feb 2009 13:05:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Enable ATAPI DMA transfers on GEN_IIE chips (6042/7042/SOC).
This also gets rid of any need for mv_mode_filter().

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-02-03 14:58:13.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-02-04 12:58:52.000000000 -0500
@@ -345,7 +345,7 @@
 	EDMA_ARB_CFG_OFS	= 0x38,
 
 	EDMA_HALTCOND_OFS	= 0x60,		/* GenIIe halt conditions */
-
+	EDMA_UNKNOWN_RSVD_OFS	= 0x6C,		/* GenIIe unknown/reserved */
 
 	BMDMA_CMD_OFS		= 0x224,	/* bmdma command register */
 	BMDMA_STATUS_OFS	= 0x228,	/* bmdma status register */
@@ -551,8 +551,6 @@
 static void mv_process_crpb_entries(struct ata_port *ap,
 					struct mv_port_priv *pp);
 
-static unsigned long mv_mode_filter(struct ata_device *dev,
-				    unsigned long xfer_mask);
 static void mv_sff_irq_clear(struct ata_port *ap);
 static int mv_check_atapi_dma(struct ata_queued_cmd *qc);
 static void mv_bmdma_setup(struct ata_queued_cmd *qc);
@@ -614,7 +612,6 @@
 	.bmdma_start		= mv_bmdma_start,
 	.bmdma_stop		= mv_bmdma_stop,
 	.bmdma_status		= mv_bmdma_status,
-	.mode_filter		= mv_mode_filter,
 };
 
 static struct ata_port_operations mv_iie_ops = {
@@ -1260,6 +1257,25 @@
 	writelfl(cfg, port_mmio + EDMA_CFG_OFS);
 }
 
+/**
+ * 	mv_bmdma_enable - set a magic bit on GEN_IIE to allow bmdma
+ * 	@ap: Port being initialized
+ */
+static void mv_bmdma_enable(struct ata_port *ap)
+{
+	struct mv_host_priv *hpriv = ap->host->private_data;
+
+	if (IS_GEN_IIE(hpriv)) {
+		void __iomem *port_mmio = mv_ap_base(ap);
+		/*
+		 * Some magic is required to get non-EDMA DMA to work:
+		 */
+		u32 rsvd = readl(port_mmio + EDMA_UNKNOWN_RSVD_OFS);
+		if (!(rsvd & 1))
+			writel(rsvd | 1, port_mmio + EDMA_UNKNOWN_RSVD_OFS);
+	}
+}
+
 static void mv_port_free_dma_mem(struct ata_port *ap)
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
@@ -1340,6 +1356,7 @@
 		}
 	}
 	mv_edma_cfg(ap, 0, 0);
+	mv_bmdma_enable(ap);
 	return 0;
 
 out_port_free_dma_mem:
@@ -1417,26 +1434,6 @@
 }
 
 /**
- *	mv_mode_filter - Allow ATAPI DMA only on GenII chips.
- *	@dev: device whose xfer modes are being configured.
- *
- *	Only the GenII hardware can use DMA with ATAPI drives.
- */
-static unsigned long mv_mode_filter(struct ata_device *adev,
-				    unsigned long xfer_mask)
-{
-	if (adev->class == ATA_DEV_ATAPI) {
-		struct mv_host_priv *hpriv = adev->link->ap->host->private_data;
-		if (!IS_GEN_II(hpriv)) {
-			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-			ata_dev_printk(adev, KERN_INFO,
-				"ATAPI DMA not supported on this chipset\n");
-		}
-	}
-	return xfer_mask;
-}
-
-/**
  *	mv_sff_irq_clear - Clear hardware interrupt after DMA.
  *	@ap: Port associated with this ATA transaction.
  *
@@ -2997,7 +2994,7 @@
 		}
 	} while (sstatus != 0x0 && sstatus != 0x113 && sstatus != 0x123);
 	mv_edma_cfg(ap, 0, 0);
-
+	mv_bmdma_enable(ap);
 	return rc;
 }
 
