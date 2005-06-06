From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/4] if condition fix for __atapi_pio_bytes()
Date: Mon, 06 Jun 2005 15:58:12 +0800
Message-ID: <42A40214.5080006@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060905090904050408010907"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:15331 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261204AbVFFH6l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 03:58:41 -0400
In-Reply-To: <42A3FF7B.3040201@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------060905090904050408010907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   In __atapi_pio_bytes(), when (bytes > qc->nbytes) or (qc->cursg_ofs > sg->length) or
(count > bytes), the if condition is not handled properly.

Changes:
- Fix the "if conditions" to make the "if conditions" more robust.

   Attached please find the patch against the linux-2.6.git tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------060905090904050408010907
Content-Type: text/plain;
 name="02_if_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02_if_fix.diff"

--- 11_atapi_pio_sg_fix/drivers/scsi/libata-core.c	2005-06-06 13:45:33.000000000 +0800
+++ 12_atapi_pio_if_condition_fix/drivers/scsi/libata-core.c	2005-06-06 13:52:11.000000000 +0800
@@ -2571,7 +2571,7 @@
 	unsigned char *buf;
 	unsigned int offset, count;
 
-	if (qc->curbytes == qc->nbytes - bytes)
+	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
@@ -2592,11 +2592,10 @@
 
 	buf = kmap(page) + offset;
 
-	bytes -= count;
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
-	if (qc->cursg_ofs == sg->length) {
+	if (qc->cursg_ofs >= sg->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2608,7 +2607,9 @@
 
 	kunmap(page);
 
-	if (bytes) {
+	if (bytes > count) {
+		bytes -= count; 
+
 		goto next_sg;
 	}
 }

--------------060905090904050408010907--


