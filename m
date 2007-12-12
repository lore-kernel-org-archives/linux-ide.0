From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: fix ATAPI draining
Date: Wed, 12 Dec 2007 12:21:52 +0900
Message-ID: <475F53D0.2040703@gmail.com>
References: <475F51AE.1010305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:32887 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbXLLDV7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 22:21:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so59120rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 11 Dec 2007 19:21:58 -0800 (PST)
In-Reply-To: <475F51AE.1010305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, will@trivescon.com.au, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

With ATAPI transfer chunk size properly programmed, libata PIO HSM
should be able to handle full spurious data chunks.  Also, it's a good
idea to suppress trailing data warning for misc ATAPI commands as
there can be many of them per command - for example, if the chunk size
is 16 and the drive tries to transfer 510 bytes, there can be 31
trailing data messages.

This patch makes the following updates to libata ATAPI PIO HSM
implementation.

* Make it drain full spurious chunks.

* Suppress trailing data warning message for misc commands.

* Put limit on how many bytes can be drained.

* If odd, round up consumed bytes and the number of bytes to be
  drained.  This gets the number of bytes to drain right for drivers
  which do 16bit PIO.

This patch is partial backport of improve-ATAPI-data-xfer patchset
pending for #upstream.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This combined with the previous patch fixes bug 9346.

 drivers/ata/libata-core.c |   87 ++++++++++++++++++++++++++++++++++------------
 include/linux/libata.h    |    2 +
 2 files changed, 67 insertions(+), 22 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -64,6 +64,7 @@
 #include <linux/libata.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
+#include <linux/cdrom.h>
 
 #include "libata.h"
 
@@ -4649,6 +4650,43 @@ int ata_check_atapi_dma(struct ata_queue
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
+	if (qc->tf.protocol != ATA_PROT_ATAPI &&
+	    qc->tf.protocol != ATA_PROT_ATAPI_DMA)
+		return 0;
+
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		return 0;
+
+	switch (qc->cdb[0]) {
+	case READ_10:
+	case READ_12:
+	case WRITE_10:
+	case WRITE_12:
+	case GPCMD_READ_CD:
+	case GPCMD_READ_CD_MSF:
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
  *	ata_std_qc_defer - Check whether a qc needs to be deferred
  *	@qc: ATA command in question
  *
@@ -5136,23 +5174,19 @@ static void atapi_send_cdb(struct ata_po
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
@@ -5161,21 +5195,28 @@ next_sg:
 		 *    - for write case, padding zero data to the device
 		 */
 		u16 pad_buf[1] = { 0 };
-		unsigned int words = bytes >> 1;
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
+		if (bytes && !atapi_qc_may_overflow(qc))
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
@@ -5210,19 +5251,20 @@ next_sg:
 	}
 
 	bytes -= count;
+	if ((count & 1) && bytes)
+		bytes--;
 	qc->curbytes += count;
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
@@ -5265,7 +5307,8 @@ static void atapi_pio_bytes(struct ata_q
 
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
