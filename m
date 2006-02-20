From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: make ata_sg_setup_one() trim zero length sg
Date: Mon, 20 Feb 2006 23:48:38 +0900
Message-ID: <11404469181022-git-send-email-htejun@gmail.com>
References: <43F9970F.9010903@pobox.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:50315 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030262AbWBTOsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 09:48:39 -0500
Received: by pproxy.gmail.com with SMTP id w49so1120834pyg
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 06:48:39 -0800 (PST)
In-Reply-To: <43F9970F.9010903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch makes ata_sg_setup_one() trim sg entry (thus making
qc->n_elem zero) if padding results in zero length sg entry.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

600e098c7092d0c0ba4c316e2cec2d1c8edc495c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bbac87a..5f1d758 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2514,7 +2514,7 @@ static void ata_sg_clean(struct ata_queu
 	assert(sg != NULL);
 
 	if (qc->flags & ATA_QCFLAG_SINGLE)
-		assert(qc->n_elem == 1);
+		assert(qc->n_elem <= 1);
 
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
@@ -2537,7 +2537,7 @@ static void ata_sg_clean(struct ata_queu
 			kunmap_atomic(addr, KM_IRQ0);
 		}
 	} else {
-		if (sg_dma_len(&sg[0]) > 0)
+		if (qc->n_elem)
 			dma_unmap_single(ap->host_set->dev,
 				sg_dma_address(&sg[0]), sg_dma_len(&sg[0]),
 				dir);
@@ -2715,6 +2715,7 @@ static int ata_sg_setup_one(struct ata_q
 	int dir = qc->dma_dir;
 	struct scatterlist *sg = qc->__sg;
 	dma_addr_t dma_address;
+	int trim_sg = 0;
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
 	qc->pad_len = sg->length & 3;
@@ -2734,13 +2735,15 @@ static int ata_sg_setup_one(struct ata_q
 		sg_dma_len(psg) = ATA_DMA_PAD_SZ;
 		/* trim sg */
 		sg->length -= qc->pad_len;
+		if (sg->length == 0)
+			trim_sg = 1;
 
 		DPRINTK("padding done, sg->length=%u pad_len=%u\n",
 			sg->length, qc->pad_len);
 	}
 
-	if (!sg->length) {
-		sg_dma_address(sg) = 0;
+	if (trim_sg) {
+		qc->n_elem--;
 		goto skip_map;
 	}
 
@@ -2753,9 +2756,9 @@ static int ata_sg_setup_one(struct ata_q
 	}
 
 	sg_dma_address(sg) = dma_address;
-skip_map:
 	sg_dma_len(sg) = sg->length;
 
+skip_map:
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
-- 
1.1.5


