From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: make ata_sg_setup_one() trim zero length sg
Date: Fri, 17 Feb 2006 16:53:09 +0900
Message-ID: <20060217075309.GA31835@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:52344 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161162AbWBQHxL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 02:53:11 -0500
Received: by pproxy.gmail.com with SMTP id x31so411938pye
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 23:53:10 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This patch makes ata_sg_setup_one() trim sg entry (thus making
qc->n_elem zero) if padding results in zero length sg entry.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, currently, in both sg_setup() and sg_setup_one() cases, zero
length sg entry can reach low level driver fill_sg() function which
could possibly cause weird problems.  This and a following patch kill
such cases.

 libata-core.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2583,7 +2583,7 @@ static void ata_sg_clean(struct ata_queu
 	WARN_ON(sg == NULL);
 
 	if (qc->flags & ATA_QCFLAG_SINGLE)
-		WARN_ON(qc->n_elem != 1);
+		WARN_ON(qc->n_elem > 1);
 
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
@@ -2606,7 +2606,7 @@ static void ata_sg_clean(struct ata_queu
 			kunmap_atomic(addr, KM_IRQ0);
 		}
 	} else {
-		if (sg_dma_len(&sg[0]) > 0)
+		if (qc->n_elem)
 			dma_unmap_single(ap->host_set->dev,
 				sg_dma_address(&sg[0]), sg_dma_len(&sg[0]),
 				dir);
@@ -2784,6 +2784,7 @@ static int ata_sg_setup_one(struct ata_q
 	int dir = qc->dma_dir;
 	struct scatterlist *sg = qc->__sg;
 	dma_addr_t dma_address;
+	int trim_sg = 0;
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
 	qc->pad_len = sg->length & 3;
@@ -2803,13 +2804,15 @@ static int ata_sg_setup_one(struct ata_q
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
 
@@ -2822,9 +2825,9 @@ static int ata_sg_setup_one(struct ata_q
 	}
 
 	sg_dma_address(sg) = dma_address;
-skip_map:
 	sg_dma_len(sg) = sg->length;
 
+skip_map:
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
