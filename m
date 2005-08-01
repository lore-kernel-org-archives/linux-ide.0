From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] libata handle the case when device returns/needs extra
 data
Date: Mon, 01 Aug 2005 23:03:18 +0800
Message-ID: <42EE39B6.5030702@tw.ibm.com>
References: <42EE37AB.2000006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020202090402070705080308"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:41980 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262120AbVHAPDj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 11:03:39 -0400
In-Reply-To: <42EE37AB.2000006@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020202090402070705080308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

PATCH 3/3:

Sometimes the device returns/needs extra data than expected.

Changes:
   - Modify __atapi_pio_bytes() to handle the case when device returns/needs extra data.
     - for read case, discard trailing data from the device
     - for write case, padding zero data to the device

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------020202090402070705080308
Content-Type: text/plain;
 name="pio3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio3.diff"

--- 02_pio_odd/drivers/scsi/libata-core.c	2005-08-01 16:14:28.000000000 +0800
+++ 03_pio_extra_data/drivers/scsi/libata-core.c	2005-08-01 21:46:37.000000000 +0800
@@ -2722,6 +2722,29 @@
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

--------------020202090402070705080308--


