From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH] sata_mv: fix broken DSM/TRIM support
Date: Thu, 19 Aug 2010 21:19:55 -0400
Message-ID: <1282267195.8909.6.camel@corey>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nfBLhm0YiO1yKssK9wcb"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:52117 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750902Ab0HTBT6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2010 21:19:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, jeff@garzik.org


--=-nfBLhm0YiO1yKssK9wcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Fix DSM/TRIM commands in sata_mv.
These need to be issued using old-school "BM DMA",
rather than via the EDMA host queue.

And since the chips don't have proper BM DMA status,
we need to be more careful with setting the ATA_DMA_INTR bit,
since DSM/TRIM often has a long delay between "DMA complete"
and "command complete".

Signed-off-by: Mark Lord <mlord@pobox.com>
---

(my apologies for broken mailers -- patch also attached in case inline is b0rked).

--- linux/drivers/ata/sata_mv.c.orig	2010-08-02 13:30:51.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2010-08-19 20:57:26.785033240 -0400
@@ -1886,19 +1886,25 @@
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
+
+		/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+		ata_sff_dma_pause(ap);
+	}
+}
 
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_sff_dma_pause(ap);
+static void mv_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	mv_bmdma_stop_ap(qc->ap);
 }
 
 /**
@@ -1922,8 +1928,21 @@
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
 
@@ -2082,6 +2101,8 @@
 	if ((tf->protocol != ATA_PROT_DMA) &&
 	    (tf->protocol != ATA_PROT_NCQ))
 		return;
+	if (tf->command == ATA_CMD_DSM)
+		return;  /* use bmdma for this */
 
 	/* Fill in Gen IIE command request block */
 	if (!(tf->flags & ATA_TFLAG_WRITE))
@@ -2277,6 +2298,8 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+		if (qc->tf.command == ATA_CMD_DSM)
+			break;  /* use bmdma for this */
 	case ATA_PROT_NCQ:
 		mv_start_edma(ap, port_mmio, pp, qc->tf.protocol);
 		pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;


--=-nfBLhm0YiO1yKssK9wcb
Content-Disposition: attachment; filename="01_sata_mv_dsm_trim_fix.patch"
Content-Type: text/x-patch; name="01_sata_mv_dsm_trim_fix.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Fix DSM/TRIM commands in sata_mv.
These need to be issued using old-school "BM DMA",
rather than via the EDMA host queue.

And since the chips don't have proper BM DMA status,
we need to be more careful with setting the ATA_DMA_INTR bit,
since DSM/TRIM often has a long delay between "DMA complete"
and "command complete".

Signed-off-by: Mark Lord <mlord@pobox.com>

--- linux/drivers/ata/sata_mv.c.orig	2010-08-02 13:30:51.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2010-08-19 20:57:26.785033240 -0400
@@ -1886,19 +1886,25 @@
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
+
+		/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+		ata_sff_dma_pause(ap);
+	}
+}
 
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_sff_dma_pause(ap);
+static void mv_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	mv_bmdma_stop_ap(qc->ap);
 }
 
 /**
@@ -1922,8 +1928,21 @@
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
 
@@ -2082,6 +2101,8 @@
 	if ((tf->protocol != ATA_PROT_DMA) &&
 	    (tf->protocol != ATA_PROT_NCQ))
 		return;
+	if (tf->command == ATA_CMD_DSM)
+		return;  /* use bmdma for this */
 
 	/* Fill in Gen IIE command request block */
 	if (!(tf->flags & ATA_TFLAG_WRITE))
@@ -2277,6 +2298,8 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+		if (qc->tf.command == ATA_CMD_DSM)
+			break;  /* use bmdma for this */
 	case ATA_PROT_NCQ:
 		mv_start_edma(ap, port_mmio, pp, qc->tf.protocol);
 		pp->req_idx = (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;

--=-nfBLhm0YiO1yKssK9wcb--

