From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 3/5] libata: add a 'struct ata_port *' argument for the ata tag help functions
Date: Thu,  3 Jul 2014 20:09:40 +0800
Message-ID: <1404389382-27298-4-git-send-email-haokexin@gmail.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48399 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaGCMKm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 08:10:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so122931pad.37
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 05:10:41 -0700 (PDT)
In-Reply-To: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

Currently we assume that all the ata host controller has a 32 queue
depth. But if a ata controller implement a queue depth less than 32,
we may need an additional 'struct ata_port *' argument to implement
these help functions. This will be used by the following patch.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/ata/libata-core.c | 18 ++++++++++--------
 drivers/ata/libata-eh.c   |  4 ++--
 drivers/ata/sata_fsl.c    | 17 ++++++++++-------
 drivers/ata/sata_nv.c     |  9 +++++----
 drivers/ata/sata_sil24.c  | 10 +++++-----
 include/linux/libata.h    | 11 ++++++-----
 6 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8807287ab7b0..f1cde0d289fa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -752,7 +752,8 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->flags |= tf_flags;
 
-	if (ata_ncq_enabled(dev) && likely(!ata_tag_internal(tag))) {
+	if (ata_ncq_enabled(dev) &&
+			likely(!ata_tag_internal(dev->link->ap, tag))) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
 			return -ERANGE;
@@ -1576,7 +1577,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	 * EH stuff without converting to it.
 	 */
 	if (ap->ops->error_handler)
-		tag = ata_get_internal_tag();
+		tag = ata_get_internal_tag(ap);
 	else
 		tag = 0;
 
@@ -4630,10 +4631,10 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 
 	if (qc->tf.protocol == ATA_PROT_NCQ) {
-		if (!ata_tag_valid(link->active_tag))
+		if (!ata_tag_valid(qc->ap, link->active_tag))
 			return 0;
 	} else {
-		if (!ata_tag_valid(link->active_tag) && !link->sactive)
+		if (!ata_tag_valid(qc->ap, link->active_tag) && !link->sactive)
 			return 0;
 	}
 
@@ -4738,7 +4739,7 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
 
 		/* the last tag is reserved for internal command. */
-		if (ata_tag_internal(tag))
+		if (ata_tag_internal(ap, tag))
 			continue;
 
 		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
@@ -4797,7 +4798,7 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 
 	qc->flags = 0;
 	tag = qc->tag;
-	if (likely(ata_tag_valid(tag))) {
+	if (likely(ata_tag_valid(ap, tag))) {
 		qc->tag = ATA_TAG_POISON;
 		clear_bit(tag, &ap->qc_allocated);
 	}
@@ -4906,7 +4907,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		 * Finish internal commands without any further processing
 		 * and always with the result TF filled.
 		 */
-		if (unlikely(ata_tag_internal(qc->tag))) {
+		if (unlikely(ata_tag_internal(ap, qc->tag))) {
 			fill_result_tf(qc);
 			__ata_qc_complete(qc);
 			return;
@@ -5035,7 +5036,8 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	 * check is skipped for old EH because it reuses active qc to
 	 * request ATAPI sense.
 	 */
-	WARN_ON_ONCE(ap->ops->error_handler && ata_tag_valid(link->active_tag));
+	WARN_ON_ONCE(ap->ops->error_handler &&
+					ata_tag_valid(ap, link->active_tag));
 
 	if (ata_is_ncq(prot)) {
 		WARN_ON_ONCE(link->sactive & (1 << qc->tag));
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6760fc4e85b8..a25af5258217 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1295,7 +1295,7 @@ static void __ata_eh_qc_complete(struct ata_queued_cmd *qc)
 	spin_lock_irqsave(ap->lock, flags);
 	qc->scsidone = ata_eh_scsidone;
 	__ata_qc_complete(qc);
-	WARN_ON(ata_tag_valid(qc->tag));
+	WARN_ON(ata_tag_valid(ap, qc->tag));
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
@@ -3328,7 +3328,7 @@ static int ata_eh_maybe_retry_flush(struct ata_device *dev)
 	int rc = 0;
 
 	/* did flush fail for this device? */
-	if (!ata_tag_valid(link->active_tag))
+	if (!ata_tag_valid(ap, link->active_tag))
 		return 0;
 
 	qc = __ata_qc_from_tag(ap, link->active_tag);
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 7fed5c5be426..bffdd96538ff 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -389,13 +389,16 @@ static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
 	return strlen(buf);
 }
 
-static inline unsigned int sata_fsl_tag(unsigned int tag,
+static inline unsigned int sata_fsl_tag(struct ata_queued_cmd *qc,
 					void __iomem *hcr_base)
 {
+	unsigned int tag = qc->tag;
+	struct ata_port *ap = qc->ap;
+
 	/* We let libATA core do actual (queue) tag allocation */
 
 	/* all non NCQ/queued commands should have tag#0 */
-	if (ata_tag_internal(tag)) {
+	if (ata_tag_internal(ap, tag)) {
 		DPRINTK("mapping internal cmds to tag#0\n");
 		return 0;
 	}
@@ -518,7 +521,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	struct sata_fsl_port_priv *pp = ap->private_data;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
-	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
+	unsigned int tag = sata_fsl_tag(qc, hcr_base);
 	struct command_desc *cd;
 	u32 desc_info = CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE;
 	u32 num_prde = 0;
@@ -565,7 +568,7 @@ static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
-	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
+	unsigned int tag = sata_fsl_tag(qc, hcr_base);
 
 	VPRINTK("xx_qc_issue called,CQ=0x%x,CA=0x%x,CE=0x%x,CC=0x%x\n",
 		ioread32(CQ + hcr_base),
@@ -594,7 +597,7 @@ static bool sata_fsl_qc_fill_rtf(struct ata_queued_cmd *qc)
 	struct sata_fsl_port_priv *pp = qc->ap->private_data;
 	struct sata_fsl_host_priv *host_priv = qc->ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
-	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
+	unsigned int tag = sata_fsl_tag(qc, hcr_base);
 	struct command_desc *cd;
 
 	cd = pp->cmdentry + tag;
@@ -1290,9 +1293,9 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
 		return;
 
-	} else if ((ap->qc_active & (1 << ata_get_internal_tag()))) {
+	} else if ((ap->qc_active & (1 << ata_get_internal_tag(ap)))) {
 		iowrite32(1, hcr_base + CC);
-		qc = ata_qc_from_tag(ap, ata_get_internal_tag());
+		qc = ata_qc_from_tag(ap, ata_get_internal_tag(ap));
 
 		DPRINTK("completing non-ncq cmd, CC=0x%x\n",
 			 ioread32(hcr_base + CC));
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index cdf99fac139a..78f7af47f0ce 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -931,7 +931,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 		if (pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
 			u8 irq_stat = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804)
 				>> (NV_INT_PORT_SHIFT * i);
-			if (ata_tag_valid(ap->link.active_tag))
+			if (ata_tag_valid(ap, ap->link.active_tag))
 				/** NV_INT_DEV indication seems unreliable
 				    at times at least in ADMA mode. Force it
 				    on always when a command is active, to
@@ -1001,7 +1001,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 
 			if (status & NV_ADMA_STAT_CPBERR) {
 				/* check all active commands */
-				if (ata_tag_valid(ap->link.active_tag))
+				if (ata_tag_valid(ap, ap->link.active_tag))
 					check_commands = 1 <<
 						ap->link.active_tag;
 				else
@@ -1675,7 +1675,8 @@ static void nv_adma_error_handler(struct ata_port *ap)
 		int i;
 		u16 tmp;
 
-		if (ata_tag_valid(ap->link.active_tag) || ap->link.sactive) {
+		if (ata_tag_valid(ap, ap->link.active_tag) ||
+			 ap->link.sactive) {
 			u32 notifier = readl(mmio + NV_ADMA_NOTIFIER);
 			u32 notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
 			u32 gen_ctl = readl(pp->gen_block + NV_ADMA_GEN_CTL);
@@ -1692,7 +1693,7 @@ static void nv_adma_error_handler(struct ata_port *ap)
 
 			for (i = 0; i < NV_ADMA_MAX_CPBS; i++) {
 				struct nv_adma_cpb *cpb = &pp->cpb[i];
-				if ((ata_tag_valid(ap->link.active_tag) && i == ap->link.active_tag) ||
+				if ((ata_tag_valid(ap, ap->link.active_tag) && i == ap->link.active_tag) ||
 				    ap->link.sactive & (1 << i))
 					ata_port_err(ap,
 						"CPB %d: ctl_flags 0x%x, resp_flags 0x%x\n",
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 0534890f118a..24bb1bd27f01 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -458,9 +458,9 @@ static const struct ata_port_info sil24_port_info[] = {
 	},
 };
 
-static int sil24_tag(int tag)
+static int sil24_tag(struct ata_port *ap, int tag)
 {
-	if (unlikely(ata_tag_internal(tag)))
+	if (unlikely(ata_tag_internal(ap, tag)))
 		return 0;
 	return tag;
 }
@@ -491,7 +491,7 @@ static void sil24_read_tf(struct ata_port *ap, int tag, struct ata_taskfile *tf)
 	struct sil24_prb __iomem *prb;
 	u8 fis[6 * 4];
 
-	prb = port + PORT_LRAM + sil24_tag(tag) * PORT_LRAM_SLOT_SZ;
+	prb = port + PORT_LRAM + sil24_tag(ap, tag) * PORT_LRAM_SLOT_SZ;
 	memcpy_fromio(fis, prb->fis, sizeof(fis));
 	ata_tf_from_fis(fis, tf);
 }
@@ -848,7 +848,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 	struct sil24_sge *sge;
 	u16 ctrl = 0;
 
-	cb = &pp->cmd_block[sil24_tag(qc->tag)];
+	cb = &pp->cmd_block[sil24_tag(ap, qc->tag)];
 
 	if (!ata_is_atapi(qc->tf.protocol)) {
 		prb = &cb->ata.prb;
@@ -890,7 +890,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = sil24_port_base(ap);
-	unsigned int tag = sil24_tag(qc->tag);
+	unsigned int tag = sil24_tag(ap, qc->tag);
 	dma_addr_t paddr;
 	void __iomem *activate;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 63462f1274df..74976a08c9bc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1474,17 +1474,18 @@ extern void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 			       const char *name);
 #endif
 
-static inline unsigned int ata_tag_valid(unsigned int tag)
+static inline unsigned int ata_tag_valid(struct ata_port *ap, unsigned int tag)
 {
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
 }
 
-static inline unsigned int ata_get_internal_tag(void)
+static inline unsigned int ata_get_internal_tag(struct ata_port *ap)
 {
 	return ATA_TAG_INTERNAL;
 }
 
-static inline unsigned int ata_tag_internal(unsigned int tag)
+static inline unsigned int ata_tag_internal(struct ata_port *ap,
+						unsigned int tag)
 {
 	return tag == ATA_TAG_INTERNAL;
 }
@@ -1536,7 +1537,7 @@ static inline int ata_link_max_devices(const struct ata_link *link)
 
 static inline int ata_link_active(struct ata_link *link)
 {
-	return ata_tag_valid(link->active_tag) || link->sactive;
+	return ata_tag_valid(link->ap, link->active_tag) || link->sactive;
 }
 
 /*
@@ -1627,7 +1628,7 @@ static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
 static inline struct ata_queued_cmd *__ata_qc_from_tag(struct ata_port *ap,
 						       unsigned int tag)
 {
-	if (likely(ata_tag_valid(tag)))
+	if (likely(ata_tag_valid(ap, tag)))
 		return &ap->qcmd[tag];
 	return NULL;
 }
-- 
1.9.3

