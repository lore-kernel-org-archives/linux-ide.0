From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata handle the case when device returns/needs extra
 data
Date: Fri, 12 Aug 2005 14:17:50 +0800
Message-ID: <42FC3F0E.7080300@tw.ibm.com>
References: <42FC3D2F.1030803@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020400090008070908070209"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:26108 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S1751137AbVHLGSU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 02:18:20 -0400
In-Reply-To: <42FC3D2F.1030803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------020400090008070908070209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

PATCH 2/2:

Description:
   Sometimes the device returns/needs extra data than expected.

Changes:
   Modify __atapi_pio_bytes() to handle the case where device returns/needs extra data.
     - for read case, discard trailing data from the device
     - for write case, padding zero data to the device

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------020400090008070908070209
Content-Type: text/plain;
 name="pio2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio2.diff"

--- 01_align/drivers/scsi/libata-core.c	2005-08-12 11:14:45.000000000 +0800
+++ 02_extra_data/drivers/scsi/libata-core.c	2005-08-12 11:14:04.000000000 +0800
@@ -2697,10 +2697,33 @@
 	unsigned char *buf;
 	unsigned int offset, count;
 
-	if (qc->curbytes == qc->nbytes - bytes)
+	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		/* 
+		 * The end of qc->sg is reached and the device expects
+		 * more data to transfer. In order not to overrun qc->sg
+		 * and fulfill length specified in the byte count register,
+		 *    - for read case, discard trailing data from the device
+		 *    - for write case, padding zero data to the device
+		 */
+		u16 pad_buf[1] = { 0 };
+		unsigned int words = bytes >> 1;
+		unsigned int i;
+
+		if (words) /* warning if bytes > 1 */
+			printk(KERN_WARNING "ata%u: %u bytes trailing data\n", 
+			       ap->id, bytes);
+
+		for (i = 0; i < words; i++)
+			ata_data_xfer(ap, (unsigned char*)pad_buf, 2, do_write);
+
+		ap->pio_task_state = PIO_ST_LAST;
+		return;
+	}
+
 	sg = &qc->sg[qc->cursg];
 
 	page = sg->page;
@@ -2734,9 +2757,8 @@
 
 	kunmap(page);
 
-	if (bytes) {
+	if (bytes)
 		goto next_sg;
-	}
 }
 
 /**

--------------020400090008070908070209--


