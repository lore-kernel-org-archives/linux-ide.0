From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH] sata_mv: fix broken DSM/TRIM support (v2)
Date: Thu, 19 Aug 2010 21:40:44 -0400
Message-ID: <1282268444.9628.4.camel@corey>
References: <1282267195.8909.6.camel@corey>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bCqIt7NsmBorWeWtmUQL"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:36819 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750824Ab0HTBkq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2010 21:40:46 -0400
In-Reply-To: <1282267195.8909.6.camel@corey>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org, jeff@garzik.org


--=-bCqIt7NsmBorWeWtmUQL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Fix DSM/TRIM commands in sata_mv (v2).
These need to be issued using old-school "BM DMA",
rather than via the EDMA host queue.

Since the chips don't have proper BM DMA status,
we need to be more careful with setting the ATA_DMA_INTR bit,
since DSM/TRIM often has a long delay between "DMA complete"
and "command complete".

GEN_I chips don't have BM DMA, so no TRIM for them.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Re-issue of original patch, with fixes for GEN_I and GEN_II chipsets.
(my apologies for broken mailers -- patch also attached in case inline is b0rked).

--- 2.6.35.2/drivers/ata/sata_mv.c	2010-08-01 18:11:14.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2010-08-19 21:34:46.139766319 -0400
@@ -1898,19 +1898,25 @@
  *	LOCKING:
  *	Inherited from caller.
  */
-static void mv_bmdma_stop(struct ata_queued_cmd *qc)
+static void mv_bmdma_stop_ap(struct ata_port *ap)
 {
-	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 cmd;
 
 	/* clear start/stop bit */
 	cmd = readl(port_mmio + BMDMA_CMD);
-	cmd &= ~ATA_DMA_START;
-	writelfl(cmd, port_mmio + BMDMA_CMD);
+	if (cmd & ATA_DMA_START) {
+		cmd &= ~ATA_DMA_START;
+		writelfl(cmd, port_mmio + BMDMA_CMD);
 
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_sff_dma_pause(ap);
+		/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+		ata_sff_dma_pause(ap);
+	}
+}
+
+static void mv_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	mv_bmdma_stop_ap(qc->ap);
 }
 
 /**
@@ -1934,8 +1940,21 @@
 	reg = readl(port_mmio + BMDMA_STATUS);
 	if (reg & ATA_DMA_ACTIVE)
 		status = ATA_DMA_ACTIVE;
-	else
+	else if (reg & ATA_DMA_ERR)
 		status = (reg & ATA_DMA_ERR) | ATA_DMA_INTR;
+	else {
+		/*
+		 * Just because DMA_ACTIVE is 0 (DMA completed),
+		 * this does _not_ mean the device is "done".
+		 * So we should not yet be signalling ATA_DMA_INTR
+		 * in some cases.  Eg. DSM/TRIM, and perhaps others.
+		 */
+		mv_bmdma_stop_ap(ap);
+		if (ioread8(ap->ioaddr.altstatus_addr) & ATA_BUSY)
+			status = 0;
+		else
+			status = ATA_DMA_INTR;
+	}
 	return status;
 }
 
@@ -1995,6 +2014,9 @@
 
 	switch (tf->protocol) {
 	case ATA_PROT_DMA:
+		if (tf->command == ATA_CMD_DSM)
+			return;
+		/* fall-thru */
 	case ATA_PROT_NCQ:
 		break;	/* continue below */
 	case ATA_PROT_PIO:
@@ -2094,6 +2116,8 @@
 	if ((tf->protocol != ATA_PROT_DMA) &&
 	    (tf->protocol != ATA_PROT_NCQ))
 		return;
+	if (tf->command == ATA_CMD_DSM)
+		return;  /* use bmdma for this */
 
 	/* Fill in Gen IIE command request block */
 	if (!(tf->flags & ATA_TFLAG_WRITE))
@@ -2289,6 +2313,12 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+		if (qc->tf.command == ATA_CMD_DSM) {
+			if (!ap->ops->bmdma_setup)  /* no bmdma on GEN_I */
+				return AC_ERR_OTHER;
+			break;  /* use bmdma for this */
+		}
+		/* fall thru */
 	case ATA_PROT_NCQ:
 		mv_start_edma(ap, port_mmio, pp, qc->tf.protocol);
 		pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;


--=-bCqIt7NsmBorWeWtmUQL
Content-Disposition: attachment; filename="01_sata_mv_dsm_trim_fix.patch"
Content-Type: text/x-patch; name="01_sata_mv_dsm_trim_fix.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Fix DSM/TRIM commands in sata_mv (v2).
These need to be issued using old-school "BM DMA",
rather than via the EDMA host queue.

Since the chips don't have proper BM DMA status,
we need to be more careful with setting the ATA_DMA_INTR bit,
since DSM/TRIM often has a long delay between "DMA complete"
and "command complete".

GEN_I chips don't have BM DMA, so no TRIM for them.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Re-issue of original patch, with fixes for GEN_I and GEN_II chipsets.
(my apologies for broken mailers -- patch also attached in case inline is b0rked).

--- 2.6.35.2/drivers/ata/sata_mv.c	2010-08-01 18:11:14.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2010-08-19 21:34:46.139766319 -0400
@@ -1898,19 +1898,25 @@
  *	LOCKING:
  *	Inherited from caller.
  */
-static void mv_bmdma_stop(struct ata_queued_cmd *qc)
+static void mv_bmdma_stop_ap(struct ata_port *ap)
 {
-	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 cmd;
 
 	/* clear start/stop bit */
 	cmd = readl(port_mmio + BMDMA_CMD);
-	cmd &= ~ATA_DMA_START;
-	writelfl(cmd, port_mmio + BMDMA_CMD);
+	if (cmd & ATA_DMA_START) {
+		cmd &= ~ATA_DMA_START;
+		writelfl(cmd, port_mmio + BMDMA_CMD);
 
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_sff_dma_pause(ap);
+		/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+		ata_sff_dma_pause(ap);
+	}
+}
+
+static void mv_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	mv_bmdma_stop_ap(qc->ap);
 }
 
 /**
@@ -1934,8 +1940,21 @@
 	reg = readl(port_mmio + BMDMA_STATUS);
 	if (reg & ATA_DMA_ACTIVE)
 		status = ATA_DMA_ACTIVE;
-	else
+	else if (reg & ATA_DMA_ERR)
 		status = (reg & ATA_DMA_ERR) | ATA_DMA_INTR;
+	else {
+		/*
+		 * Just because DMA_ACTIVE is 0 (DMA completed),
+		 * this does _not_ mean the device is "done".
+		 * So we should not yet be signalling ATA_DMA_INTR
+		 * in some cases.  Eg. DSM/TRIM, and perhaps others.
+		 */
+		mv_bmdma_stop_ap(ap);
+		if (ioread8(ap->ioaddr.altstatus_addr) & ATA_BUSY)
+			status = 0;
+		else
+			status = ATA_DMA_INTR;
+	}
 	return status;
 }
 
@@ -1995,6 +2014,9 @@
 
 	switch (tf->protocol) {
 	case ATA_PROT_DMA:
+		if (tf->command == ATA_CMD_DSM)
+			return;
+		/* fall-thru */
 	case ATA_PROT_NCQ:
 		break;	/* continue below */
 	case ATA_PROT_PIO:
@@ -2094,6 +2116,8 @@
 	if ((tf->protocol != ATA_PROT_DMA) &&
 	    (tf->protocol != ATA_PROT_NCQ))
 		return;
+	if (tf->command == ATA_CMD_DSM)
+		return;  /* use bmdma for this */
 
 	/* Fill in Gen IIE command request block */
 	if (!(tf->flags & ATA_TFLAG_WRITE))
@@ -2289,6 +2313,12 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+		if (qc->tf.command == ATA_CMD_DSM) {
+			if (!ap->ops->bmdma_setup)  /* no bmdma on GEN_I */
+				return AC_ERR_OTHER;
+			break;  /* use bmdma for this */
+		}
+		/* fall thru */
 	case ATA_PROT_NCQ:
 		mv_start_edma(ap, port_mmio, pp, qc->tf.protocol);
 		pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;

--=-bCqIt7NsmBorWeWtmUQL--

