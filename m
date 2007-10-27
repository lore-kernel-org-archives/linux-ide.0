From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: [PATCH-RFC] (was: Re: Sata Sil3512 bug?;  Promise SATA300 TX4)
Date: Sat, 27 Oct 2007 17:24:32 +0400
Message-ID: <47233C10.4020100@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info> <47194497.3040101@gmail.com> <471A783E.9060607@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:50260 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbXJ0NeP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 09:34:15 -0400
In-Reply-To: <471A783E.9060607@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, MisterE <MisterE2002@zonnet.nl>, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

Hello.

There appears to be a hardware bug in that it chokes on scatterlist
if the last item is larger than 164 bytes.

The patch that follows fixes my problem on 2.6.22.

I can't think of a way to avoid second pass over scatterlist without
duplicating code (ata_qc_prep() and ata_fill_sg() from libata-core.c).


--- a/drivers/ata/sata_promise.c	2007-07-09 03:32:17.000000000 +0400
+++ b/drivers/ata/sata_promise.c	2007-10-27 17:20:03.000000000 +0400
@@ -531,6 +531,80 @@
 	memcpy(buf+31, cdb, cdb_len);
 }

+/**
+ *	pdc_qc_prep - Fill PCI IDE PRD table
+ *	@qc: Metadata associated with taskfile to be transferred
+ *
+ *	Fill PCI IDE PRD (scatter-gather) table with segments
+ *	associated with the current disk command.
+ *	Make sure hardware does not choke on it.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ */
+static void pdc_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scatterlist *sg;
+	unsigned int idx;
+	const u32 SG_COUNT_ASIC_BUG = 41*4;
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+	
+	WARN_ON(qc->__sg == NULL);
+	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
+
+	idx = 0;
+	ata_for_each_sg(sg, qc) {
+		u32 addr, offset;
+		u32 sg_len, len;
+
+		/* determine if physical DMA addr spans 64K boundary.
+		 * Note h/w doesn't support 64-bit, so we unconditionally
+		 * truncate dma_addr_t to u32.
+		 */
+		addr = (u32) sg_dma_address(sg);
+		sg_len = sg_dma_len(sg);
+
+		while (sg_len) {
+			offset = addr & 0xffff;
+			len = sg_len;
+			if ((offset + sg_len) > 0x10000)
+				len = 0x10000 - offset;
+
+			ap->prd[idx].addr = cpu_to_le32(addr);
+			ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+
+			idx++;
+			sg_len -= len;
+			addr += len;
+		}
+	}
+
+	if (idx) {
+		u32 len = ap->prd[idx - 1].flags_len;
+		if (len > SG_COUNT_ASIC_BUG) {
+			u32 addr, len;
+
+			VPRINTK("Last PRD split\n");
+			
+			len = le32_to_cpu(ap->prd[idx - 1].flags_len) - SG_COUNT_ASIC_BUG;
+			addr = le32_to_cpu(ap->prd[idx - 1].addr);
+			ap->prd[idx - 1].flags_len = cpu_to_le32(len);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+			
+			ap->prd[idx].flags_len = cpu_to_le32(SG_COUNT_ASIC_BUG);
+			ap->prd[idx].addr = cpu_to_le32(addr + len);
+			idx++;
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr + len, SG_COUNT_ASIC_BUG);
+		}
+		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	}
+}
+
 static void pdc_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pdc_port_priv *pp = qc->ap->private_data;
@@ -540,7 +614,7 @@

 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		ata_qc_prep(qc);
+		pdc_qc_prep(qc);
 		/* fall through */

 	case ATA_PROT_NODATA:

