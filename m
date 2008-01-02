From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: update ATAPI overflow draining
Date: Wed,  2 Jan 2008 20:12:48 +0900
Message-ID: <11992723711166-git-send-email-htejun@gmail.com>
References: <11992723701811-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:20530 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233AbYABLM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 06:12:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so9016561wah.23
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 03:12:57 -0800 (PST)
In-Reply-To: <11992723701811-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

For misc ATAPI commands which transfer variable length data to the
host, overflow can occur due to application or hardware bug.  Such
overflows can be ignored safely as long as overflow data is properly
drained.  libata HSM implementation has this implemented in
__atapi_pio_bytes() and recently updated for 2.6.24-rc but it requires
further improvements.  Improve drain logic such that...

* Report overflow errors using ehi desc mechanism instead of printing
  directly.

* Properly calculate the number of bytes to be drained considering
  actual number of consumed bytes for partial draining.

* Add and use ata_drain_page for draining.  This change fixes the
  problem where LLDs which do 32bit IOs consumes 4 bytes on each 2
  byte draining resulting in draining twice more data than requested.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Acked-by: Albert Lee <albertcc@tw.ibm.com>
---
 drivers/ata/libata-core.c |  104 +++++++++++++++++++++++----------------------
 1 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9d040a3..3dbac19 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,8 +84,8 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 unsigned int ata_print_id = 1;
 static struct workqueue_struct *ata_wq;
-
 struct workqueue_struct *ata_aux_wq;
+static void *ata_drain_page;
 
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
@@ -4658,24 +4658,9 @@ int ata_check_atapi_dma(struct ata_queued_cmd *qc)
  */
 static int atapi_qc_may_overflow(struct ata_queued_cmd *qc)
 {
-	if (qc->tf.protocol != ATAPI_PROT_PIO &&
-	    qc->tf.protocol != ATAPI_PROT_DMA)
-		return 0;
-
-	if (qc->tf.flags & ATA_TFLAG_WRITE)
-		return 0;
-
-	switch (qc->cdb[0]) {
-	case READ_10:
-	case READ_12:
-	case WRITE_10:
-	case WRITE_12:
-	case GPCMD_READ_CD:
-	case GPCMD_READ_CD_MSF:
-		return 0;
-	}
-
-	return 1;
+	return ata_is_atapi(qc->tf.protocol) && ata_is_data(qc->tf.protocol) &&
+		atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC &&
+		!(qc->tf.flags & ATA_TFLAG_WRITE);
 }
 
 /**
@@ -5129,13 +5114,14 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
  */
 static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
-	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	int rw = (qc->tf.flags & ATA_TFLAG_WRITE) ? WRITE : READ;
 	struct ata_port *ap = qc->ap;
-	struct ata_eh_info *ehi = &qc->dev->link->eh_info;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
 	struct scatterlist *sg;
 	struct page *page;
 	unsigned char *buf;
-	unsigned int offset, count;
+	unsigned int offset, count, consumed;
 
 next_sg:
 	sg = qc->cursg;
@@ -5147,27 +5133,29 @@ next_sg:
 		 *    - for read case, discard trailing data from the device
 		 *    - for write case, padding zero data to the device
 		 */
-		u16 pad_buf[1] = { 0 };
-		unsigned int i;
-
-		if (bytes > qc->curbytes - qc->nbytes + ATAPI_MAX_DRAIN) {
+		if (qc->curbytes + bytes > qc->nbytes + ATAPI_MAX_DRAIN) {
 			ata_ehi_push_desc(ehi, "too much trailing data "
 					  "buf=%u cur=%u bytes=%u",
 					  qc->nbytes, qc->curbytes, bytes);
 			return -1;
 		}
 
-		 /* overflow is exptected for misc ATAPI commands */
-		if (bytes && !atapi_qc_may_overflow(qc))
-			ata_dev_printk(qc->dev, KERN_WARNING, "ATAPI %u bytes "
-				       "trailing data (cdb=%02x nbytes=%u)\n",
-				       bytes, qc->cdb[0], qc->nbytes);
+		/* allow overflow only for misc ATAPI commands */
+		if (!atapi_qc_may_overflow(qc)) {
+			ata_ehi_push_desc(ehi, "unexpected trailing data "
+					  "%u bytes", bytes);
+			return -1;
+		}
 
-		for (i = 0; i < (bytes + 1) / 2; i++)
-			ap->ops->data_xfer(qc->dev, (unsigned char *)pad_buf, 2, do_write);
+		consumed = 0;
+		while (consumed < bytes) {
+			count = min_t(unsigned int,
+				      bytes - consumed, PAGE_SIZE);
+			consumed += ap->ops->data_xfer(dev, ata_drain_page,
+						       count, rw);
+		}
 
 		qc->curbytes += bytes;
-
 		return 0;
 	}
 
@@ -5194,18 +5182,16 @@ next_sg:
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
-	if ((count & 1) && bytes)
-		bytes--;
+	bytes -= min(bytes, consumed);
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
@@ -5214,9 +5200,11 @@ next_sg:
 		qc->cursg_ofs = 0;
 	}
 
+	/* consumed can be larger than count only for the last transfer */
+	WARN_ON(qc->cursg && count != consumed);
+
 	if (bytes)
 		goto next_sg;
-
 	return 0;
 }
 
@@ -5234,6 +5222,7 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
 	unsigned int ireason, bc_lo, bc_hi, bytes;
 	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
 
@@ -5251,26 +5240,28 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 
 	/* shall be cleared to zero, indicating xfer of data */
 	if (unlikely(ireason & (1 << 0)))
-		goto err_out;
+		goto atapi_check;
 
 	/* make sure transfer direction matches expected */
 	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
 	if (unlikely(do_write != i_write))
-		goto err_out;
+		goto atapi_check;
 
 	if (unlikely(!bytes))
-		goto err_out;
+		goto atapi_check;
 
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
-	if (__atapi_pio_bytes(qc, bytes))
+	if (unlikely(__atapi_pio_bytes(qc, bytes)))
 		goto err_out;
 	ata_altstatus(ap); /* flush */
 
 	return;
 
-err_out:
-	ata_dev_printk(dev, KERN_INFO, "ATAPI check failed\n");
+ atapi_check:
+	ata_ehi_push_desc(ehi, "ATAPI check failed (ireason=0x%x bytes=%u)",
+			  ireason, bytes);
+ err_out:
 	qc->err_mask |= AC_ERR_HSM;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
@@ -7404,24 +7395,35 @@ int ata_pci_device_resume(struct pci_dev *pdev)
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
-- 
1.5.2.4

