From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] sata_sil24: implement NCQ support
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <11473586833833-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:8463 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751810AbWEKOoz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:55 -0400
Received: by wr-out-0506.google.com with SMTP id 55so345876wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:54 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement NCQ support.  Sil24 has 31 command slots and all of them are
used for NCQ command queueing.  libata guarantees that no other
command is in progress when it issues an internal command, so always
use tag 0 for internal commands.

---

 drivers/scsi/sata_sil24.c |   68 +++++++++++++++++++++++++++++++--------------
 1 files changed, 47 insertions(+), 21 deletions(-)

16de6240bcc7474f1d4c36982445b4e81a5b90ea
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index adbb5a6..202d34e 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -216,6 +216,8 @@ enum {
 	SGE_DRD			= (1 << 29), /* discard data read (/dev/null)
 						data address ignored */
 
+	SIL24_MAX_CMDS		= 31,
+
 	/* board id */
 	BID_SIL3124		= 0,
 	BID_SIL3132		= 1,
@@ -223,7 +225,8 @@ enum {
 
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_NCQ,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -355,7 +358,8 @@ static struct scsi_host_template sil24_s
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= SIL24_MAX_CMDS,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
@@ -437,6 +441,13 @@ static struct ata_port_info sil24_port_i
 	},
 };
 
+static int sil24_tag(int tag)
+{
+	if (unlikely(ata_tag_internal(tag)))
+		return 0;
+	return tag;
+}
+
 static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -649,14 +660,17 @@ static void sil24_qc_prep(struct ata_que
 {
 	struct ata_port *ap = qc->ap;
 	struct sil24_port_priv *pp = ap->private_data;
-	union sil24_cmd_block *cb = pp->cmd_block + qc->tag;
+	union sil24_cmd_block *cb;
 	struct sil24_prb *prb;
 	struct sil24_sge *sge;
 	u16 ctrl = 0;
 
+	cb = &pp->cmd_block[sil24_tag(qc->tag)];
+
 	switch (qc->tf.protocol) {
 	case ATA_PROT_PIO:
 	case ATA_PROT_DMA:
+	case ATA_PROT_NCQ:
 	case ATA_PROT_NODATA:
 		prb = &cb->ata.prb;
 		sge = cb->ata.sge;
@@ -694,12 +708,17 @@ static void sil24_qc_prep(struct ata_que
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
-	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	unsigned int tag = sil24_tag(qc->tag);
+	dma_addr_t paddr;
+	void __iomem *activate;
 
-	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
-	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
+	paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
+	activate = port + PORT_CMD_ACTIVATE + tag * 8;
+
+	writel((u32)paddr, activate);
+	writel((u64)paddr >> 32, activate + 4);
 
 	return 0;
 }
@@ -791,9 +810,6 @@ static void sil24_error_intr(struct ata_
 		/* record error info */
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc) {
-			int tag = qc->tag;
-			if (unlikely(ata_tag_internal(tag)))
-				tag = 0;
 			sil24_update_tf(ap);
 			qc->err_mask |= err_mask;
 		} else
@@ -809,11 +825,17 @@ static void sil24_error_intr(struct ata_
 		ata_port_abort(ap);
 }
 
+static void sil24_finish_qc(struct ata_queued_cmd *qc)
+{
+	if (qc->flags & ATA_QCFLAG_RESULT_TF)
+		sil24_update_tf(qc->ap);
+}
+
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	struct ata_queued_cmd *qc;
-	u32 slot_stat;
+	u32 slot_stat, qc_active;
+	int rc;
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
 
@@ -825,18 +847,22 @@ static inline void sil24_host_intr(struc
 	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
 		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (qc) {
-		if (qc->flags & ATA_QCFLAG_RESULT_TF)
-			sil24_update_tf(ap);
-		ata_qc_complete(qc);
+	qc_active = slot_stat & ~HOST_SSTAT_ATTN;
+	rc = ata_qc_complete_multiple(ap, qc_active, sil24_finish_qc);
+	if (rc > 0)
+		return;
+	if (rc < 0) {
+		struct ata_eh_info *ehi = &ap->eh_info;
+		ehi->err_mask |= AC_ERR_HSM;
+		ehi->action |= ATA_EH_SOFTRESET;
+		ata_port_freeze(ap);
 		return;
 	}
 
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-			"(slot_stat 0x%x active_tag %d)\n",
-			slot_stat, ap->active_tag);
+			"(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
+			slot_stat, ap->active_tag, ap->sactive);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
@@ -903,7 +929,7 @@ static void sil24_post_internal_cmd(stru
 
 static inline void sil24_cblk_free(struct sil24_port_priv *pp, struct device *dev)
 {
-	const size_t cb_size = sizeof(*pp->cmd_block);
+	const size_t cb_size = sizeof(*pp->cmd_block) * SIL24_MAX_CMDS;
 
 	dma_free_coherent(dev, cb_size, pp->cmd_block, pp->cmd_block_dma);
 }
@@ -913,7 +939,7 @@ static int sil24_port_start(struct ata_p
 	struct device *dev = ap->host_set->dev;
 	struct sil24_port_priv *pp;
 	union sil24_cmd_block *cb;
-	size_t cb_size = sizeof(*cb);
+	size_t cb_size = sizeof(*cb) * SIL24_MAX_CMDS;
 	dma_addr_t cb_dma;
 	int rc = -ENOMEM;
 
-- 
1.2.4


