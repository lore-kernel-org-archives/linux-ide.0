From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 9/9] sata_sx4.c conversion
Date: Thu, 29 Jun 2006 18:10:34 +0200
Message-ID: <20060629161034.GJ23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.plus.mail.re2.yahoo.com ([206.190.53.27]:27819 "HELO
	smtp102.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750880AbWF2QLW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:11:22 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Convert the sata-sx4.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

--- libata-dev/drivers/scsi/sata_sx4.c.orig	2006-06-29 16:52:41.000000000 +0200
+++ libata-dev/drivers/scsi/sata_sx4.c	2006-06-29 17:14:36.000000000 +0200
@@ -462,7 +462,8 @@ static void pdc20621_dma_prep(struct ata
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
-	VPRINTK("ata%u: ENTER\n", ap->id);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ata%u: ENTER\n", 
+			__FUNCTION__, ap->id);
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -507,7 +508,9 @@ static void pdc20621_dma_prep(struct ata
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
+	ata_port_printk(ap, ATA_MSG_CMD, 
+			"ata pkt buf ofs %u, prd size %u, mmio copied\n", 
+			i, sgt_len);
 }
 
 static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
@@ -520,7 +523,8 @@ static void pdc20621_nodata_prep(struct 
 	unsigned int portno = ap->port_no;
 	unsigned int i;
 
-	VPRINTK("ata%u: ENTER\n", ap->id);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ata%u: ENTER\n", 
+			__FUNCTION__, ap->id);
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
@@ -543,7 +547,8 @@ static void pdc20621_nodata_prep(struct 
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, mmio copied\n", i);
+	ata_port_printk(ap, ATA_MSG_CMD, 
+			"ata pkt buf ofs %u, mmio copied\n", i);
 }
 
 static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
@@ -626,10 +631,14 @@ static void pdc20621_dump_hdma(struct at
 	dimm_mmio += (port_no * PDC_DIMM_WINDOW_STEP);
 	dimm_mmio += PDC_DIMM_HOST_PKT;
 
-	printk(KERN_ERR "HDMA[0] == 0x%08X\n", readl(dimm_mmio));
-	printk(KERN_ERR "HDMA[1] == 0x%08X\n", readl(dimm_mmio + 4));
-	printk(KERN_ERR "HDMA[2] == 0x%08X\n", readl(dimm_mmio + 8));
-	printk(KERN_ERR "HDMA[3] == 0x%08X\n", readl(dimm_mmio + 12));
+	ata_port_printk(ap, ATA_MSG_ERR "HDMA[0] == 0x%08X\n", 
+			readl(dimm_mmio));
+	ata_port_printk(ap, ATA_MSG_ERR "HDMA[1] == 0x%08X\n", 
+			readl(dimm_mmio + 4));
+	ata_port_printk(ap, ATA_MSG_ERR "HDMA[2] == 0x%08X\n", 
+			readl(dimm_mmio + 8));
+	ata_port_printk(ap, ATA_MSG_ERR "HDMA[3] == 0x%08X\n", 
+			readl(dimm_mmio + 12));
 }
 #else
 static inline void pdc20621_dump_hdma(struct ata_queued_cmd *qc) { }
@@ -648,7 +657,8 @@ static void pdc20621_packet_start(struct
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	VPRINTK("ata%u: ENTER\n", ap->id);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ata%u: ENTER\n", 
+			__FUNCTION__, ap->id);
 
 	wmb();			/* flush PRD, pkt writes */
 
@@ -660,10 +670,11 @@ static void pdc20621_packet_start(struct
 
 		pdc20621_dump_hdma(qc);
 		pdc20621_push_hdma(qc, seq, port_ofs + PDC_DIMM_HOST_PKT);
-		VPRINTK("queued ofs 0x%x (%u), seq %u\n",
-			port_ofs + PDC_DIMM_HOST_PKT,
-			port_ofs + PDC_DIMM_HOST_PKT,
-			seq);
+		ata_port_printk(ap, ATA_MSG_CMD, 
+				"queued ofs 0x%x (%u), seq %u\n",
+				port_ofs + PDC_DIMM_HOST_PKT,
+				port_ofs + PDC_DIMM_HOST_PKT,
+				seq);
 	} else {
 		writel(0x00000001, mmio + PDC_20621_SEQCTL + (seq * 4));
 		readl(mmio + PDC_20621_SEQCTL + (seq * 4));	/* flush */
@@ -671,10 +682,11 @@ static void pdc20621_packet_start(struct
 		writel(port_ofs + PDC_DIMM_ATA_PKT,
 		       (void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
 		readl((void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-		VPRINTK("submitted ofs 0x%x (%u), seq %u\n",
-			port_ofs + PDC_DIMM_ATA_PKT,
-			port_ofs + PDC_DIMM_ATA_PKT,
-			seq);
+		ata_port_printk(ap, ATA_MSG_CMD, 
+				"submitted ofs 0x%x (%u), seq %u\n",
+				port_ofs + PDC_DIMM_ATA_PKT,
+				port_ofs + PDC_DIMM_ATA_PKT,
+				seq);
 	}
 }
 
@@ -708,15 +720,17 @@ static inline unsigned int pdc20621_host
 	u8 status;
 	unsigned int handled = 0;
 
-	VPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if ((qc->tf.protocol == ATA_PROT_DMA) &&	/* read */
 	    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 
 		/* step two - DMA from DIMM to host */
 		if (doing_hdma) {
-			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
-				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
+			ata_port_printk(ap, ATA_MSG_CMD, 
+					"ata%u: read hdma, 0x%x 0x%x\n", ap->id,
+					readl(mmio + 0x104), 
+					readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
 			ata_qc_complete(qc);
@@ -726,8 +740,10 @@ static inline unsigned int pdc20621_host
 		/* step one - exec ATA command */
 		else {
 			u8 seq = (u8) (port_no + 1 + 4);
-			VPRINTK("ata%u: read ata, 0x%x 0x%x\n", ap->id,
-				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
+			ata_port_printk(ap, ATA_MSG_CMD, 
+					"ata%u: read ata, 0x%x 0x%x\n", 
+					ap->id,	readl(mmio + 0x104), 
+					readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit hdma pkt */
 			pdc20621_dump_hdma(qc);
@@ -741,8 +757,10 @@ static inline unsigned int pdc20621_host
 		/* step one - DMA from host to DIMM */
 		if (doing_hdma) {
 			u8 seq = (u8) (port_no + 1);
-			VPRINTK("ata%u: write hdma, 0x%x 0x%x\n", ap->id,
-				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
+			ata_port_printk(ap, ATA_MSG_CMD, 
+					"ata%u: write hdma, 0x%x 0x%x\n", 
+					ap->id,	readl(mmio + 0x104), 
+					readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit ata pkt */
 			writel(0x00000001, mmio + PDC_20621_SEQCTL + (seq * 4));
@@ -754,8 +772,10 @@ static inline unsigned int pdc20621_host
 
 		/* step two - execute ATA command */
 		else {
-			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
-				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
+			ata_port_printk(ap, ATA_MSG_CMD, 
+					"ata%u: write ata, 0x%x 0x%x\n", 
+					ap->id,	readl(mmio + 0x104), 
+					readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
 			ata_qc_complete(qc);
@@ -767,7 +787,8 @@ static inline unsigned int pdc20621_host
 	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
 
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		ata_port_printk(ap, ATA_MSG_CMD, 
+				"BUS_NODATA (drv_stat 0x%X)\n", status);
 		qc->err_mask |= ac_err_mask(status);
 		ata_qc_complete(qc);
 		handled = 1;
@@ -861,7 +882,7 @@ static void pdc_eng_timeout(struct ata_p
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
@@ -870,14 +891,14 @@ static void pdc_eng_timeout(struct ata_p
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		ata_port_printk(ap, KERN_ERR, "command timeout\n");
+		ata_port_printk(ap, ATA_MSG_ERR, "command timeout\n");
 		qc->err_mask |= __ac_err_mask(ata_wait_idle(ap));
 		break;
 
 	default:
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-		ata_port_printk(ap, KERN_ERR,
+		ata_port_printk(ap, ATA_MSG_ERR,
 				"unknown timeout, cmd 0x%x stat 0x%x\n",
 				qc->tf.command, drv_stat);
 
@@ -887,7 +908,7 @@ static void pdc_eng_timeout(struct ata_p
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 	ata_eh_qc_complete(qc);
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

