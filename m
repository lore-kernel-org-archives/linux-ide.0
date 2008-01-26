From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/13] sata_mv ncq Add want ncq parameter for EDMA configuration
Date: Sat, 26 Jan 2008 18:31:33 -0500
Message-ID: <479BC2D5.5010705@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3052 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbYAZXbe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:31:34 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

An extra EDMA config bit is required for NCQ operation.
So set/clear it as needed, and cache current setting in port_priv.
For now though, it will always be "off" (0).

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 12:12:37.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 12:07:16.000000000 -0500
@@ -331,6 +331,7 @@
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
+	MV_PP_FLAG_NCQ_EN	= (1 << 1),	/* is EDMA set up for NCQ? */
 	MV_PP_FLAG_HAD_A_RESET	= (1 << 2),	/* 1st hard reset complete? */
 };
 
@@ -471,8 +472,9 @@
 static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio);
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
-static void mv_edma_cfg(struct ata_port *ap, struct mv_host_priv *hpriv,
-			void __iomem *port_mmio);
+static void mv_edma_cfg(struct mv_port_priv *pp, struct mv_host_priv *hpriv,
+			void __iomem *port_mmio, int want_ncq);
+static int __mv_stop_dma(struct ata_port *ap);
 
 static struct scsi_host_template mv5_sht = {
 	.module			= THIS_MODULE,
@@ -838,8 +840,15 @@
  *      Inherited from caller.
  */
 static void mv_start_dma(struct ata_port *ap, void __iomem *port_mmio,
-			 struct mv_port_priv *pp)
+			 struct mv_port_priv *pp, u8 protocol)
 {
+	int want_ncq = (protocol == ATA_PROT_NCQ);
+
+	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
+		int using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
+		if (want_ncq != using_ncq)
+			__mv_stop_dma(ap);
+	}
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 		struct mv_host_priv *hpriv = ap->host->private_data;
 		int hard_port = mv_hardport_from_port(ap->port_no);
@@ -859,7 +868,7 @@
 				 hc_mmio + HC_IRQ_CAUSE_OFS);
 		}
 
-		mv_edma_cfg(ap, hpriv, port_mmio);
+		mv_edma_cfg(pp, hpriv, port_mmio, want_ncq);
 
 		/* clear FIS IRQ Cause */
 		writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
@@ -1045,8 +1054,8 @@
 		return -EINVAL;
 }
 
-static void mv_edma_cfg(struct ata_port *ap, struct mv_host_priv *hpriv,
-			void __iomem *port_mmio)
+static void mv_edma_cfg(struct mv_port_priv *pp, struct mv_host_priv *hpriv,
+			void __iomem *port_mmio, int want_ncq)
 {
 	u32 cfg;
 
@@ -1066,6 +1075,12 @@
 		cfg |= (1 << 17);	/* enab cut-through (dis stor&forwrd) */
 	}
 
+	if (want_ncq) {
+		cfg |= EDMA_CFG_NCQ;
+		pp->pp_flags |=  MV_PP_FLAG_NCQ_EN;
+	} else
+		pp->pp_flags &= ~MV_PP_FLAG_NCQ_EN;
+
 	writelfl(cfg, port_mmio + EDMA_CFG_OFS);
 }
 
@@ -1128,7 +1143,7 @@
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 
-	mv_edma_cfg(ap, hpriv, port_mmio);
+	mv_edma_cfg(pp, hpriv, port_mmio, 0);
 
 	mv_set_edma_ptrs(port_mmio, hpriv, pp);
 
@@ -1396,7 +1411,7 @@
 		return ata_qc_issue_prot(qc);
 	}
 
-	mv_start_dma(ap, port_mmio, pp);
+	mv_start_dma(ap, port_mmio, pp, qc->tf.protocol);
 
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
 
