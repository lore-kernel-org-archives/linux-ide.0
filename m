From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6/6] libata: Protect DMA core code by #ifdef CONFIG_HAS_DMA
Date: Tue,  3 Jan 2017 19:09:49 +0100
Message-ID: <1483466989-9091-7-git-send-email-geert@linux-m68k.org>
References: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:42666 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759601AbdACSKa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2017 13:10:30 -0500
In-Reply-To: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/ata/libata.ko] undefined!

To fix this, protect the DMA code by #ifdef CONFIG_HAS_DMA, and provide
dummies of ata_sg_clean() and ata_sg_setup() for the !CONFIG_HAS_DMA
case.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/libata-core.c | 61 +++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a7e3df5abaa3124f..dc70b5f997f1f13e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4814,32 +4814,6 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 }
 
 /**
- *	ata_sg_clean - Unmap DMA memory associated with command
- *	@qc: Command containing DMA memory to be released
- *
- *	Unmap all mapped DMA memory associated with this command.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-static void ata_sg_clean(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg = qc->sg;
-	int dir = qc->dma_dir;
-
-	WARN_ON_ONCE(sg == NULL);
-
-	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
-
-	if (qc->n_elem)
-		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
-
-	qc->flags &= ~ATA_QCFLAG_DMAMAP;
-	qc->sg = NULL;
-}
-
-/**
  *	atapi_check_dma - Check whether ATAPI DMA can be supported
  *	@qc: Metadata associated with taskfile to check
  *
@@ -4923,6 +4897,34 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 	qc->cursg = qc->sg;
 }
 
+#ifdef CONFIG_HAS_DMA
+
+/**
+ *	ata_sg_clean - Unmap DMA memory associated with command
+ *	@qc: Command containing DMA memory to be released
+ *
+ *	Unmap all mapped DMA memory associated with this command.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_sg_clean(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scatterlist *sg = qc->sg;
+	int dir = qc->dma_dir;
+
+	WARN_ON_ONCE(sg == NULL);
+
+	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
+
+	if (qc->n_elem)
+		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
+
+	qc->flags &= ~ATA_QCFLAG_DMAMAP;
+	qc->sg = NULL;
+}
+
 /**
  *	ata_sg_setup - DMA-map the scatter-gather table associated with a command.
  *	@qc: Command with scatter-gather table to be mapped.
@@ -4955,6 +4957,13 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	return 0;
 }
 
+#else /* !CONFIG_HAS_DMA */
+
+static inline void ata_sg_clean(struct ata_queued_cmd *qc) {}
+static inline int ata_sg_setup(struct ata_queued_cmd *qc) { return -1; }
+
+#endif /* !CONFIG_HAS_DMA */
+
 /**
  *	swap_buf_le16 - swap halves of 16-bit words in place
  *	@buf:  Buffer to swap
-- 
1.9.1

