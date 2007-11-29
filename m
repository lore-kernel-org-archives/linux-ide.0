From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/14] libata: improve ATAPI draining
Date: Thu, 29 Nov 2007 23:33:29 +0900
Message-ID: <11963468192463-git-send-email-htejun@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:17452 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761759AbXK2Odu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 09:33:50 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1455011nze
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 06:33:49 -0800 (PST)
In-Reply-To: <1196346817387-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>, Albert Lee <albertcc@tw.ibm.com>

For misc ATAPI commands which transfer variable length data to the
host, overflow can occur due to application or hardware bug.  Such
overflows can be ignored safely as long as overflow data is properly
drained.  libata HSM implementation has this implemented in
__atapi_pio_bytes() but it isn't enough.  Improve drain logic such
that...

* Multiple PIO data phases are allowed.  Not allowing this used to be
  okay when transfer chunk size was set to 8k unconditionally but with
  transfer hcunk size set to allocation size, treating extra PIO data
  phases as HSM violations cause a lot of trouble.

* Limit the amount of draining to ATAPI_MAX_DRAIN (16k currently).

* Don't whine if overflow is allowed and safe.  When unexpected
  overflow occurs, trigger HSM violation and report the problem using
  ehi error description.

* Properly calculate the number of bytes to be drained considering
  actual number of consumed bytes for partial draining.

* Add and use ata_drain_page for draining.  This change fixes the
  problem where LLDs which do 32bit IOs consumes 4 bytes on each 2
  byte draining resulting in draining twice more data than requested.

This patch fixes ATAPI regressions introduced by setting transfer
chunk size to allocation size.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>
---
 drivers/ata/libata-core.c |  128 ++++++++++++++++++++++++++++++---------------
 include/linux/libata.h    |    2 +
 2 files changed, 88 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 10f3b42..76b8dc9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -83,8 +83,8 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 unsigned int ata_print_id = 1;
 static struct workqueue_struct *ata_wq;
-
 struct workqueue_struct *ata_aux_wq;
+static void *ata_drain_page;
 
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
@@ -4671,6 +4671,28 @@ int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 /**
+ *	atapi_qc_may_overflow - Check whether data transfer may overflow
+ *	@qc: ATA command in question
+ *
+ *	ATAPI commands which transfer variable length data to host
+ *	might overflow due to application error or hardare bug.  This
+ *	function checks whether overflow should be drained and ignored
+ *	for @qc.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if @qc may overflow; otherwise, 0.
+ */
+static int atapi_qc_may_overflow(struct ata_queued_cmd *qc)
+{
+	return ata_is_atapi(qc->tf.protocol) && ata_is_data(qc->tf.protocol) &&
+		atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC &&
+		!(qc->tf.flags & ATA_TFLAG_WRITE);
+}
+
+/**
  *	ata_std_qc_defer - Check whether a qc needs to be deferred
  *	@qc: ATA command in question
  *
@@ -5172,23 +5194,23 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
  *	Inherited from caller.
  *
  */
-
-static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
+static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
-	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct scatterlist *sg = qc->__sg;
-	struct scatterlist *lsg = sg_last(qc->__sg, qc->n_elem);
+	int rw = (qc->tf.flags & ATA_TFLAG_WRITE) ? WRITE : READ;
 	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
+	struct scatterlist *sg;
 	struct page *page;
 	unsigned char *buf;
-	unsigned int offset, count;
-	int no_more_sg = 0;
-
-	if (qc->curbytes + bytes >= qc->nbytes)
-		ap->hsm_task_state = HSM_ST_LAST;
+	unsigned int offset, count, consumed;
 
 next_sg:
-	if (unlikely(no_more_sg)) {
+	if (!bytes)
+		return 0;
+
+	sg = qc->cursg;
+	if (unlikely(!sg)) {
 		/*
 		 * The end of qc->sg is reached and the device expects
 		 * more data to transfer. In order not to overrun qc->sg
@@ -5196,23 +5218,32 @@ next_sg:
 		 *    - for read case, discard trailing data from the device
 		 *    - for write case, padding zero data to the device
 		 */
-		u16 pad_buf[1] = { 0 };
-		unsigned int words = bytes >> 1;
-		unsigned int i;
+		if (qc->curbytes + bytes > qc->nbytes + ATAPI_MAX_DRAIN) {
+			ata_ehi_push_desc(ehi, "too much trailing data "
+					  "buf=%u cur=%u bytes=%u",
+					  qc->nbytes, qc->curbytes, bytes);
+			return -1;
+		}
 
-		if (words) /* warning if bytes > 1 */
-			ata_dev_printk(qc->dev, KERN_WARNING,
-				       "%u bytes trailing data\n", bytes);
+		/* allow overflow only for misc ATAPI commands */
+		if (!atapi_qc_may_overflow(qc)) {
+			ata_ehi_push_desc(ehi, "unexpected trailing data "
+					  "%u bytes", bytes);
+			return -1;
+		}
 
-		for (i = 0; i < words; i++)
-			ap->ops->data_xfer(qc->dev, (unsigned char *)pad_buf, 2, do_write);
+		consumed = 0;
+		while (consumed < bytes) {
+			count = min_t(unsigned int,
+				      bytes - consumed, PAGE_SIZE);
+			consumed += ap->ops->data_xfer(dev, ata_drain_page,
+						       count, rw);
+		}
 
-		ap->hsm_task_state = HSM_ST_LAST;
-		return;
+		qc->curbytes += bytes;
+		return 0;
 	}
 
-	sg = qc->cursg;
-
 	page = sg_page(sg);
 	offset = sg->offset + qc->cursg_ofs;
 
@@ -5236,29 +5267,28 @@ next_sg:
 		buf = kmap_atomic(page, KM_IRQ0);
 
 		/* do the actual data transfer */
-		ap->ops->data_xfer(qc->dev,  buf + offset, count, do_write);
+		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
 
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev,  buf + offset, count, do_write);
+		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
 	}
 
-	bytes -= count;
+	bytes -= min(bytes, consumed);
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
 	if (qc->cursg_ofs == sg->length) {
-		if (qc->cursg == lsg)
-			no_more_sg = 1;
-
 		qc->cursg = sg_next(qc->cursg);
 		qc->cursg_ofs = 0;
 	}
 
-	if (bytes)
-		goto next_sg;
+	/* consumed can be larger than count only for the last transfer */
+	WARN_ON(qc->cursg && count != consumed);
+
+	goto next_sg;
 }
 
 /**
@@ -5275,6 +5305,7 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
 	unsigned int ireason, bc_lo, bc_hi, bytes;
 	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
 
@@ -5292,22 +5323,24 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 
 	/* shall be cleared to zero, indicating xfer of data */
 	if (ireason & (1 << 0))
-		goto err_out;
+		goto atapi_check;
 
 	/* make sure transfer direction matches expected */
 	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
 	if (do_write != i_write)
-		goto err_out;
+		goto atapi_check;
 
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
-	__atapi_pio_bytes(qc, bytes);
+	if (__atapi_pio_bytes(qc, bytes))
+		goto err_out;
 	ata_altstatus(ap); /* flush */
 
 	return;
 
-err_out:
-	ata_dev_printk(dev, KERN_INFO, "ATAPI check failed\n");
+ atapi_check:
+	ata_ehi_push_desc(ehi, "ATAPI check failed ireason=0x%x", ireason);
+ err_out:
 	qc->err_mask |= AC_ERR_HSM;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
@@ -7429,24 +7462,35 @@ int ata_pci_device_resume(struct pci_dev *pdev)
 static int __init ata_init(void)
 {
 	ata_probe_timeout *= HZ;
+
+	ata_drain_page = (void *)__get_free_page(GFP_DMA32);
+	if (!ata_drain_page)
+		goto err_drain_page;
+
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
-		return -ENOMEM;
+		goto err_ata_wq;
 
 	ata_aux_wq = create_singlethread_workqueue("ata_aux");
-	if (!ata_aux_wq) {
-		destroy_workqueue(ata_wq);
-		return -ENOMEM;
-	}
+	if (!ata_aux_wq)
+		goto err_ata_aux_wq;
 
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
+
+ err_ata_aux_wq:
+	destroy_workqueue(ata_wq);
+ err_ata_wq:
+	free_page((unsigned long)ata_drain_page);
+ err_drain_page:
+	return -ENOMEM;
 }
 
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
 	destroy_workqueue(ata_aux_wq);
+	free_page((unsigned long)ata_drain_page);
 }
 
 subsys_initcall(ata_init);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4b39650..a2070cf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -120,6 +120,8 @@ enum {
 	ATA_DEF_BUSY_WAIT	= 10000,
 	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
 
+	ATAPI_MAX_DRAIN		= 16 << 10,
+
 	ATA_SHT_EMULATED	= 1,
 	ATA_SHT_CMD_PER_LUN	= 1,
 	ATA_SHT_THIS_ID		= -1,
-- 
1.5.2.4

