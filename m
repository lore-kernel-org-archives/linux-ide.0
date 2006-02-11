From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: convert assert(X)'s in libata core layer to WARN_ON(!X)'s
Date: Sat, 11 Feb 2006 19:11:13 +0900
Message-ID: <1139652673362-git-send-email-htejun@gmail.com>
References: <11396526734098-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:38553 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751383AbWBKKLR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 05:11:17 -0500
Received: by zproxy.gmail.com with SMTP id n1so641959nzf
        for <linux-ide@vger.kernel.org>; Sat, 11 Feb 2006 02:11:16 -0800 (PST)
In-Reply-To: <11396526734098-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

In an effort to kill libata-specific assert() and use generic
WARN_ON(), this patch converts all assert(X)'s in libata core layer to
WARN_ON(!X)'s.  Most conversions are straight-forward logical negation
exception for the followings.

* In libata-core.c:ata_fill_sg(),
  assert(qc->n_elem > 0) is converted to WARN_ON(qc->n_elem == 0) because
  qc->n_elem is unsigned and unsigned <= 0 is weird.

* In libata-scsi.c:ata_gen_ata_desc/fixed_sense(),
  assert(NULL != qc->ap->ops->tf_read) is converted to
  WARN_ON(qc->ap->ops->tf_read == NULL), as there are no other users of
  'constant cond var' style in libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++----------------------
 drivers/scsi/libata-scsi.c |   14 +++++++------
 2 files changed, 30 insertions(+), 30 deletions(-)

89261226ba2baa00a04f07699ca6bbe17dec8980
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fffbaa9..cef85e5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -904,8 +904,8 @@ static void ata_dev_identify(struct ata_
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
 
-	assert (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ATAPI ||
-		dev->class == ATA_DEV_NONE);
+	WARN_ON(dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ATAPI &&
+		dev->class != ATA_DEV_NONE);
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
@@ -2301,7 +2301,7 @@ static unsigned int ata_get_mode_mask(co
 	master = &ap->device[0];
 	slave = &ap->device[1];
 
-	assert (ata_dev_present(master) || ata_dev_present(slave));
+	WARN_ON(!ata_dev_present(master) && !ata_dev_present(slave));
 
 	if (shift == ATA_SHIFT_UDMA) {
 		mask = ap->udma_mask;
@@ -2547,11 +2547,11 @@ static void ata_sg_clean(struct ata_queu
 	int dir = qc->dma_dir;
 	void *pad_buf = NULL;
 
-	assert(qc->flags & ATA_QCFLAG_DMAMAP);
-	assert(sg != NULL);
+	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
+	WARN_ON(sg == NULL);
 
 	if (qc->flags & ATA_QCFLAG_SINGLE)
-		assert(qc->n_elem == 1);
+		WARN_ON(qc->n_elem != 1);
 
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
@@ -2606,8 +2606,8 @@ static void ata_fill_sg(struct ata_queue
 	struct scatterlist *sg;
 	unsigned int idx;
 
-	assert(qc->__sg != NULL);
-	assert(qc->n_elem > 0);
+	WARN_ON(qc->__sg == NULL);
+	WARN_ON(qc->n_elem == 0);
 
 	idx = 0;
 	ata_for_each_sg(sg, qc) {
@@ -2759,7 +2759,7 @@ static int ata_sg_setup_one(struct ata_q
 		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
 		struct scatterlist *psg = &qc->pad_sgent;
 
-		assert(qc->dev->class == ATA_DEV_ATAPI);
+		WARN_ON(qc->dev->class != ATA_DEV_ATAPI);
 
 		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
 
@@ -2821,7 +2821,7 @@ static int ata_sg_setup(struct ata_queue
 	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
 	VPRINTK("ENTER, ata%u\n", ap->id);
-	assert(qc->flags & ATA_QCFLAG_SG);
+	WARN_ON(!(qc->flags & ATA_QCFLAG_SG));
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
 	qc->pad_len = lsg->length & 3;
@@ -2830,7 +2830,7 @@ static int ata_sg_setup(struct ata_queue
 		struct scatterlist *psg = &qc->pad_sgent;
 		unsigned int offset;
 
-		assert(qc->dev->class == ATA_DEV_ATAPI);
+		WARN_ON(qc->dev->class != ATA_DEV_ATAPI);
 
 		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
 
@@ -2924,7 +2924,7 @@ static unsigned long ata_pio_poll(struct
 	unsigned int reg_state = HSM_ST_UNKNOWN;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
+	WARN_ON(qc == NULL);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
@@ -2992,7 +2992,7 @@ static int ata_pio_complete (struct ata_
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
+	WARN_ON(qc == NULL);
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
@@ -3003,7 +3003,7 @@ static int ata_pio_complete (struct ata_
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	assert(qc->err_mask == 0);
+	WARN_ON(qc->err_mask);
 	ata_poll_qc_complete(qc);
 
 	/* another command may start at this point */
@@ -3360,7 +3360,7 @@ static void ata_pio_block(struct ata_por
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
+	WARN_ON(qc == NULL);
 
 	/* check error */
 	if (status & (ATA_ERR | ATA_DF)) {
@@ -3397,12 +3397,12 @@ static void ata_pio_error(struct ata_por
 	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
+	WARN_ON(qc == NULL);
 
 	/* make sure qc->err_mask is available to 
 	 * know what's wrong and recover
 	 */
-	assert(qc->err_mask);
+	WARN_ON(qc->err_mask == 0);
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
@@ -3609,7 +3609,7 @@ void ata_qc_free(struct ata_queued_cmd *
 	struct ata_port *ap = qc->ap;
 	unsigned int tag;
 
-	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
+	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
 
 	qc->flags = 0;
 	tag = qc->tag;
@@ -3623,8 +3623,8 @@ void ata_qc_free(struct ata_queued_cmd *
 
 void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
-	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->flags & ATA_QCFLAG_ACTIVE);
+	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
+	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
 
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
@@ -4155,8 +4155,8 @@ static void atapi_packet_task(void *_dat
 	u8 status;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
-	assert(qc->flags & ATA_QCFLAG_ACTIVE);
+	WARN_ON(qc == NULL);
+	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
 
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
@@ -4174,7 +4174,7 @@ static void atapi_packet_task(void *_dat
 
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
-	assert(ap->cdb_len >= 12);
+	WARN_ON(ap->cdb_len < 12);
 
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
 	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9d67c67..26f07a2 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -553,7 +553,7 @@ void ata_gen_ata_desc_sense(struct ata_q
 	/*
 	 * Read the controller registers.
 	 */
-	assert(NULL != qc->ap->ops->tf_read);
+	WARN_ON(qc->ap->ops->tf_read == NULL);
 	qc->ap->ops->tf_read(qc->ap, tf);
 
 	/*
@@ -628,7 +628,7 @@ void ata_gen_fixed_sense(struct ata_queu
 	/*
 	 * Read the controller registers.
 	 */
-	assert(NULL != qc->ap->ops->tf_read);
+	WARN_ON(qc->ap->ops->tf_read == NULL);
 	qc->ap->ops->tf_read(qc->ap, tf);
 
 	/*
@@ -746,7 +746,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (qc) {
-		assert(qc->scsicmd == cmd);
+		WARN_ON(qc->scsicmd != cmd);
 		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
 		qc->err_mask |= AC_ERR_TIMEOUT;
 		ret = EH_NOT_HANDLED;
@@ -780,14 +780,14 @@ int ata_scsi_error(struct Scsi_Host *hos
 	ap = (struct ata_port *) &host->hostdata[0];
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	assert(!(ap->flags & ATA_FLAG_IN_EH));
+	WARN_ON(ap->flags & ATA_FLAG_IN_EH);
 	ap->flags |= ATA_FLAG_IN_EH;
-	assert(ata_qc_from_tag(ap, ap->active_tag) != NULL);
+	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	ap->ops->eng_timeout(ap);
 
-	assert(host->host_failed == 0 && list_empty(&host->eh_cmd_q));
+	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q));
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
@@ -813,7 +813,7 @@ static void __ata_eh_qc_complete(struct 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	qc->scsidone = ata_eh_scsidone;
 	__ata_qc_complete(qc);
-	assert(!ata_tag_valid(qc->tag));
+	WARN_ON(ata_tag_valid(qc->tag));
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
-- 
1.1.5


