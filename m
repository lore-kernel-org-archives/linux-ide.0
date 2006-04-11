From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/15] sata_sil24: implement NCQ support
Date: Tue, 11 Apr 2006 22:53:37 +0900
Message-ID: <11447636174068-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:43136 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750980AbWDKNxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:49 -0400
Received: by pproxy.gmail.com with SMTP id i49so1388582pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:49 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement NCQ support.  Sil24 has 31 command slots and all of them are
used for NCQ command queueing.  libata guarantees that no other
command is in progress when it issues an internal command, so always
use tag 0 for internal commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   79 +++++++++++++++++++++++++++++++++------------
 1 files changed, 58 insertions(+), 21 deletions(-)

83fbbc40a0cca8a044f50d6097fe819cfb11b750
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index c2c5ed9..6a7ea97 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -217,6 +217,8 @@ enum {
 	SGE_DRD			= (1 << 29), /* discard data read (/dev/null)
 						data address ignored */
 
+	SIL24_MAX_CMDS		= 31,
+
 	/* board id */
 	BID_SIL3124		= 0,
 	BID_SIL3132		= 1,
@@ -224,7 +226,8 @@ enum {
 
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_NCQ,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -358,6 +361,8 @@ static struct scsi_host_template sil24_s
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= SIL24_MAX_CMDS,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
@@ -666,14 +671,21 @@ static void sil24_qc_prep(struct ata_que
 {
 	struct ata_port *ap = qc->ap;
 	struct sil24_port_priv *pp = ap->private_data;
-	union sil24_cmd_block *cb = pp->cmd_block + qc->tag;
+	unsigned int tag;
+	union sil24_cmd_block *cb;
 	struct sil24_prb *prb;
 	struct sil24_sge *sge;
 	u16 ctrl = 0;
 
+	tag = qc->tag;
+	if (unlikely(ata_tag_internal(tag)))
+		tag = 0;
+	cb = &pp->cmd_block[tag];
+
 	switch (qc->tf.protocol) {
 	case ATA_PROT_PIO:
 	case ATA_PROT_DMA:
+	case ATA_PROT_NCQ:
 	case ATA_PROT_NODATA:
 		prb = &cb->ata.prb;
 		sge = cb->ata.sge;
@@ -711,12 +723,21 @@ static void sil24_qc_prep(struct ata_que
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
-	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	void __iomem *activate;
+	unsigned int tag;
+	dma_addr_t paddr;
+
+	tag = qc->tag;
+	if (unlikely(ata_tag_internal(tag)))
+		tag = 0;
 
-	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
-	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
+	paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
+	activate = port + PORT_CMD_ACTIVATE + tag * 8;
+
+	writel((u32)paddr, activate);
+	writel((u64)paddr >> 32, activate + 4);
 
 	return 0;
 }
@@ -821,7 +842,7 @@ static void sil24_error_handler(struct a
 	/* perform recovery */
 	action |= sil24_eh_autopsy(ap, irq_stat, &err_mask, desc, sizeof(desc));
 
-	qc = ata_eh_determine_qc(ap, 0, &tf);
+	qc = ata_eh_determine_qc(ap, err_mask & AC_ERR_DEV, &tf);
 	if (qc)
 		qc->err_mask |= err_mask;
 
@@ -846,7 +867,6 @@ static void sil24_post_internal_cmd(stru
 
 static inline void sil24_host_intr(struct ata_port *ap)
 {
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 slot_stat, irq_stat;
@@ -857,18 +877,35 @@ static inline void sil24_host_intr(struc
 		if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
 			writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
 
-		/* !HOST_SSAT_ATTN guarantees successful completion,
-		 * so reading back tf registers is unnecessary for
-		 * most commands.  TODO: read tf registers for
-		 * commands which require these values on successful
-		 * completion (EXECUTE DEVICE DIAGNOSTIC, CHECK POWER,
-		 * DEVICE RESET and READ PORT MULTIPLIER (any more?).
-		 */
-		sil24_update_tf(ap);
+		if (ap->sactive) {
+			if (ata_ncq_complete(ap, slot_stat & ~HOST_SSTAT_ATTN))
+				return;
+		} else {
+			struct ata_queued_cmd *qc;
+
+			/* !HOST_SSAT_ATTN guarantees successful
+			 * completion, so reading back tf registers is
+			 * unnecessary for most commands.  TODO: read
+			 * tf registers for commands which require
+			 * these values on successful completion
+			 * (EXECUTE DEVICE DIAGNOSTIC, CHECK POWER,
+			 * DEVICE RESET and READ PORT MULTIPLIER (any
+			 * more?).
+			 */
+			sil24_update_tf(ap);
+
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc) {
+				qc->err_mask |= ac_err_mask(pp->tf.command);
+				ata_qc_complete(qc);
+				return;
+			}
+		}
 
-		if (qc) {
-			qc->err_mask |= ac_err_mask(pp->tf.command);
-			ata_qc_complete(qc);
+		if (ata_ratelimit()) {
+			printk(KERN_INFO "ata%u: spurious interrupt "
+			       "(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
+			       ap->id, slot_stat, ap->active_tag, ap->sactive);
 		}
 
 		return;
@@ -926,7 +963,7 @@ static irqreturn_t sil24_interrupt(int i
 
 static inline void sil24_cblk_free(struct sil24_port_priv *pp, struct device *dev)
 {
-	const size_t cb_size = sizeof(*pp->cmd_block);
+	const size_t cb_size = sizeof(*pp->cmd_block) * SIL24_MAX_CMDS;
 
 	dma_free_coherent(dev, cb_size, pp->cmd_block, pp->cmd_block_dma);
 }
@@ -936,7 +973,7 @@ static int sil24_port_start(struct ata_p
 	struct device *dev = ap->host_set->dev;
 	struct sil24_port_priv *pp;
 	union sil24_cmd_block *cb;
-	size_t cb_size = sizeof(*cb);
+	size_t cb_size = sizeof(*cb) * SIL24_MAX_CMDS;
 	dma_addr_t cb_dma;
 	int rc = -ENOMEM;
 
-- 
1.2.4


