From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/4] libata: trailing data handling fix for __atapi_pio_bytes()
Date: Fri, 10 Jun 2005 15:44:20 +0800
Message-ID: <42A944D4.3030100@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A7ED91.4090008@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060105000002000506000700"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:52711 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261511AbVFJHph (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2005 03:45:37 -0400
In-Reply-To: <42A7ED91.4090008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------060105000002000506000700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Resend the patch #3.

Problem:
    Sometimes CD-ROM drives will ask/return more data than expected.

Changes:
- Handle the trailing data if the end of qc->sg has been reached.


Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------060105000002000506000700
Content-Type: text/plain;
 name="03_trailing_data.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03_trailing_data.diff"

--- 12_atapi_pio_if_condition_fix/drivers/scsi/libata-core.c	2005-06-06 13:52:11.000000000 +0800
+++ 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c	2005-06-09 11:05:10.000000000 +0800
@@ -2575,6 +2575,23 @@
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		unsigned char pad_buf[2];
+		unsigned int words = bytes >> 1;
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

--------------060105000002000506000700--


