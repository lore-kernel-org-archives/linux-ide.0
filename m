From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream] libata: kill duplicate functions
Date: Wed, 04 Jul 2007 17:58:00 +0900
Message-ID: <468B6118.5040500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:41853 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbXGDI6G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:58:06 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1504214nze
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 01:58:05 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I like these _dumb functions but I think we can live with just one
copy.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   79 ----------------------------------------------
 1 file changed, 79 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -4165,68 +4165,6 @@ static void ata_fill_sg_dumb(struct ata_
 }
 
 /**
- *	ata_fill_sg_dumb - Fill PCI IDE PRD table
- *	@qc: Metadata associated with taskfile to be transferred
- *
- *	Fill PCI IDE PRD (scatter-gather) table with segments
- *	associated with the current disk command. Perform the fill
- *	so that we avoid writing any length 64K records for
- *	controllers that don't follow the spec.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- */
-static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg;
-	unsigned int idx;
-
-	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
-
-	idx = 0;
-	ata_for_each_sg(sg, qc) {
-		u32 addr, offset;
-		u32 sg_len, len, blen;
-
- 		/* determine if physical DMA addr spans 64K boundary.
-		 * Note h/w doesn't support 64-bit, so we unconditionally
-		 * truncate dma_addr_t to u32.
-		 */
-		addr = (u32) sg_dma_address(sg);
-		sg_len = sg_dma_len(sg);
-
-		while (sg_len) {
-			offset = addr & 0xffff;
-			len = sg_len;
-			if ((offset + sg_len) > 0x10000)
-				len = 0x10000 - offset;
-
-			blen = len & 0xffff;
-			ap->prd[idx].addr = cpu_to_le32(addr);
-			if (blen == 0) {
-				/* Some PATA chipsets like the CS5530 can't
-				   cope with 0x0000 meaning 64K as the spec says */
-				ap->prd[idx].flags_len = cpu_to_le32(0x8000);
-				blen = 0x8000;
-				ap->prd[++idx].addr = cpu_to_le32(addr + 0x8000);
-			}
-			ap->prd[idx].flags_len = cpu_to_le32(blen);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
-
-			idx++;
-			sg_len -= len;
-			addr += len;
-		}
-	}
-
-	if (idx)
-		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
-}
-
-/**
  *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
  *	@qc: Metadata associated with taskfile to check
  *
@@ -4290,23 +4228,6 @@ void ata_dumb_qc_prep(struct ata_queued_
 	ata_fill_sg_dumb(qc);
 }
 
-/**
- *	ata_dumb_qc_prep - Prepare taskfile for submission
- *	@qc: Metadata associated with taskfile to be prepared
- *
- *	Prepare ATA taskfile for submission.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_dumb_qc_prep(struct ata_queued_cmd *qc)
-{
-	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
-
-	ata_fill_sg_dumb(qc);
-}
-
 void ata_noop_qc_prep(struct ata_queued_cmd *qc) { }
 
 /**
