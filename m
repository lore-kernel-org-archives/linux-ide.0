From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/4] trailing data handling fix for __atapi_pio_bytes()
Date: Mon, 06 Jun 2005 15:59:57 +0800
Message-ID: <42A4027D.9070007@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020308040800090405060809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:30693 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261207AbVFFIAS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 04:00:18 -0400
In-Reply-To: <42A3FF7B.3040201@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------020308040800090405060809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   Sometimes CD-ROM drives will ask/return more data than expected.

Changes:
- Handle the trailing data if the end of qc->sg has been reached.

Attached please find the patch against the linux-2.6.git tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------020308040800090405060809
Content-Type: text/plain;
 name="03_trailing_data.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03_trailing_data.diff"

--- 12_atapi_pio_if_condition_fix/drivers/scsi/libata-core.c	2005-06-06 13:52:11.000000000 +0800
+++ 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c	2005-06-06 13:57:18.000000000 +0800
@@ -2575,6 +2575,23 @@
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		unsigned char pad_buf[2];
+		unsigned int words = (bytes+1) >> 1; /* pad to word boundary */
+		unsigned int i;
+
+		DPRINTK("ata%u: padding %u bytes\n", ap->id, bytes);
+
+		memset(&pad_buf, 0, sizeof(pad_buf));
+		for (i = 0; i < words; i++) {
+			ata_data_xfer(ap, pad_buf, sizeof(pad_buf), do_write);
+		}
+
+		ap->pio_task_state = PIO_ST_LAST;
+		return;
+	}
+
 	sg = &qc->sg[qc->cursg];
 
 	page = sg->page;

--------------020308040800090405060809--


