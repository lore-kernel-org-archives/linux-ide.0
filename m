From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] libata: improve ATAPI draining
Date: Wed, 28 Nov 2007 00:13:51 +0900
Message-ID: <11961764403671-git-send-email-htejun@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:54873 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbXK0POP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:15 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688067roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:15 -0800 (PST)
In-Reply-To: <11961764391983-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

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

* If the device indicates that it wants to transfer odd number of
  bytes, it should be rounded up not down.

This patch fixes ATAPI regressions introduced by setting transfer
chunk size to allocation size.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   68 +++++++++++++++++++++++++++++++---------------
 include/linux/libata.h    |    2 +
 2 files changed, 49 insertions(+), 21 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -4671,6 +4671,28 @@ int ata_check_atapi_dma(struct ata_queue
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
@@ -5158,23 +5180,19 @@ static void atapi_send_cdb(struct ata_po
  *	Inherited from caller.
  *
  */
-
-static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
+static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct scatterlist *sg = qc->__sg;
-	struct scatterlist *lsg = sg_last(qc->__sg, qc->n_elem);
 	struct ata_port *ap = qc->ap;
+	struct ata_eh_info *ehi = &qc->dev->link->eh_info;
+	struct scatterlist *sg;
 	struct page *page;
 	unsigned char *buf;
 	unsigned int offset, count;
-	int no_more_sg = 0;
-
-	if (qc->curbytes + bytes >= qc->nbytes)
-		ap->hsm_task_state = HSM_ST_LAST;
 
 next_sg:
-	if (unlikely(no_more_sg)) {
+	sg = qc->cursg;
+	if (unlikely(!sg)) {
 		/*
 		 * The end of qc->sg is reached and the device expects
 		 * more data to transfer. In order not to overrun qc->sg
@@ -5186,18 +5204,26 @@ next_sg:
 		unsigned int words = bytes >> 1;
 		unsigned int i;
 
-		if (words) /* warning if bytes > 1 */
-			ata_dev_printk(qc->dev, KERN_WARNING,
-				       "%u bytes trailing data\n", bytes);
+		if (bytes > qc->curbytes - qc->nbytes + ATAPI_MAX_DRAIN) {
+			ata_ehi_push_desc(ehi, "too much trailing data "
+					  "buf=%u cur=%u bytes=%u",
+					  qc->nbytes, qc->curbytes, bytes);
+			return -1;
+		}
+
+		 /* overflow is exptected for misc ATAPI commands */
+		if (words && !atapi_qc_may_overflow(qc))
+			ata_dev_printk(qc->dev, KERN_WARNING, "ATAPI %u bytes "
+				       "trailing data (cdb=%02x nbytes=%u)\n",
+				       bytes, qc->cdb[0], qc->nbytes);
 
-		for (i = 0; i < words; i++)
+		for (i = 0; i < (bytes + 1) / 2; i++)
 			ap->ops->data_xfer(qc->dev, (unsigned char *)pad_buf, 2, do_write);
 
-		ap->hsm_task_state = HSM_ST_LAST;
-		return;
-	}
+		qc->curbytes += bytes;
 
-	sg = qc->cursg;
+		return 0;
+	}
 
 	page = sg_page(sg);
 	offset = sg->offset + qc->cursg_ofs;
@@ -5236,15 +5262,14 @@ next_sg:
 	qc->cursg_ofs += count;
 
 	if (qc->cursg_ofs == sg->length) {
-		if (qc->cursg == lsg)
-			no_more_sg = 1;
-
 		qc->cursg = sg_next(qc->cursg);
 		qc->cursg_ofs = 0;
 	}
 
 	if (bytes)
 		goto next_sg;
+
+	return 0;
 }
 
 /**
@@ -5287,7 +5312,8 @@ static void atapi_pio_bytes(struct ata_q
 
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
-	__atapi_pio_bytes(qc, bytes);
+	if (__atapi_pio_bytes(qc, bytes))
+		goto err_out;
 	ata_altstatus(ap); /* flush */
 
 	return;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -119,6 +119,8 @@ enum {
 	ATA_DEF_BUSY_WAIT	= 10000,
 	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
 
+	ATAPI_MAX_DRAIN		= 16 << 10,
+
 	ATA_SHT_EMULATED	= 1,
 	ATA_SHT_CMD_PER_LUN	= 1,
 	ATA_SHT_THIS_ID		= -1,
