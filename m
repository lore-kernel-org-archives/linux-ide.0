From: Aubin LaBrosse <aubin@stormboxes.com>
Subject: [PATCH] Replace assert() with WARN_ON in drivers/scsi/libata-core.c
Date: Mon, 13 Feb 2006 18:35:19 -0500
Message-ID: <20060213233518.15196.57162.stgit@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.stormboxes.com ([207.234.184.232]:45717 "EHLO
	dedicated.stormboxes.com") by vger.kernel.org with ESMTP
	id S1030294AbWBMXgu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Feb 2006 18:36:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, aubin@stormboxes.com


Replace assert() with WARN_ON in drivers/scsi/libata-core.c

This is my first patch to the kernel - this work was suggested by Jeff Garzik as a janitorial task for libata.  If I could get some feedback letting me know that this is the correct format and my tools are setup right, I'll do the rest of these.

Signed-off-by: Aubin LaBrosse <aubin@stormboxes.com>
---

 drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 46c4cdb..3397396 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1251,8 +1251,8 @@ static void ata_dev_identify(struct ata_
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
 
-	assert (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ATAPI ||
-		dev->class == ATA_DEV_NONE);
+	WARN_ON(dev->class != ATA_DEV_ATA &&&dev->class != ATA_DEV_ATAPI &&
+		dev->class != ATA_DEV_NONE);
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
@@ -2264,7 +2264,7 @@ static unsigned int ata_get_mode_mask(co
 	master = &ap->device[0];
 	slave = &ap->device[1];
 
-	assert (ata_dev_present(master) || ata_dev_present(slave));
+	WARN_ON(!ata_dev_present(master) && !ata_dev_present(slave));
 
 	if (shift == ATA_SHIFT_UDMA) {
 		mask = ap->udma_mask;
@@ -2510,11 +2510,11 @@ static void ata_sg_clean(struct ata_queu
 	int dir = qc->dma_dir;
 	void *pad_buf = NULL;
 
-	assert(qc->flags & ATA_QCFLAG_DMAMAP);
-	assert(sg != NULL);
+	WARN_ON(~qc->flags & ATA_QCFLAG_DMAMAP);
+	WARN_ON(sg == NULL);
 
 	if (qc->flags & ATA_QCFLAG_SINGLE)
-		assert(qc->n_elem == 1);
+		WARN_ON(qc->n_elem != 1);
 
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
@@ -2569,8 +2569,8 @@ static void ata_fill_sg(struct ata_queue
 	struct scatterlist *sg;
 	unsigned int idx;
 
-	assert(qc->__sg != NULL);
-	assert(qc->n_elem > 0);
+	WARN_ON(qc->__sg == NULL);
+	WARN_ON(qc->n_elem <= 0);
 
 	idx = 0;
 	ata_for_each_sg(sg, qc) {
@@ -2722,7 +2722,7 @@ static int ata_sg_setup_one(struct ata_q
 		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
 		struct scatterlist *psg = &qc->pad_sgent;
 
-		assert(qc->dev->class == ATA_DEV_ATAPI);
+		WARN_ON(qc->dev->class != ATA_DEV_ATAPI);
 
 		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
 
@@ -2784,7 +2784,7 @@ static int ata_sg_setup(struct ata_queue
 	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
 	VPRINTK("ENTER, ata%u\n", ap->id);
-	assert(qc->flags & ATA_QCFLAG_SG);
+	WARN_ON(~qc->flags & ATA_QCFLAG_SG);
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
 	qc->pad_len = lsg->length & 3;
@@ -2793,7 +2793,7 @@ static int ata_sg_setup(struct ata_queue
 		struct scatterlist *psg = &qc->pad_sgent;
 		unsigned int offset;
 
-		assert(qc->dev->class == ATA_DEV_ATAPI);
+		WARN_ON(qc->dev->class != ATA_DEV_ATAPI);
 
 		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
 
@@ -2887,7 +2887,7 @@ static unsigned long ata_pio_poll(struct
 	unsigned int reg_state = HSM_ST_UNKNOWN;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
+	WARN_ON(qc == NULL);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
@@ -2955,7 +2955,7 @@ static int ata_pio_complete (struct ata_
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
+	WARN_ON(qc == NULL);
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
@@ -2966,7 +2966,7 @@ static int ata_pio_complete (struct ata_
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	assert(qc->err_mask == 0);
+	WARN_ON(qc->err_mask != 0);
 	ata_poll_qc_complete(qc);
 
 	/* another command may start at this point */
@@ -3323,7 +3323,7 @@ static void ata_pio_block(struct ata_por
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
+	WARN_ON(qc == NULL);
 
 	/* check error */
 	if (status & (ATA_ERR | ATA_DF)) {
@@ -3360,12 +3360,12 @@ static void ata_pio_error(struct ata_por
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
 
@@ -3598,7 +3598,7 @@ static void __ata_qc_complete(struct ata
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
-	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
+	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
 
 	__ata_qc_complete(qc);
 }
@@ -3619,8 +3619,8 @@ void ata_qc_complete(struct ata_queued_c
 {
 	int rc;
 
-	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->flags & ATA_QCFLAG_ACTIVE);
+	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
+	WARN_ON(~qc->flags & ATA_QCFLAG_ACTIVE);
 
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
@@ -4160,8 +4160,8 @@ static void atapi_packet_task(void *_dat
 	u8 status;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
-	assert(qc->flags & ATA_QCFLAG_ACTIVE);
+	WARN_ON(qc == NULL);
+	WARN_ON(~qc->flags & ATA_QCFLAG_ACTIVE);
 
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
@@ -4179,7 +4179,7 @@ static void atapi_packet_task(void *_dat
 
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
-	assert(ap->cdb_len >= 12);
+	WARN_ON(ap->cdb_len < 12);
 
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
 	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {

