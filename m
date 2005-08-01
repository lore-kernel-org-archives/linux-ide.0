From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/3] libata "if condition" enhancement
Date: Mon, 01 Aug 2005 22:57:50 +0800
Message-ID: <42EE386E.604@tw.ibm.com>
References: <42EE37AB.2000006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000901030804070209080208"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:33788 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262103AbVHAO6U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 10:58:20 -0400
In-Reply-To: <42EE37AB.2000006@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000901030804070209080208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

PATCH 1/3: "if condition" enhancement.

Changes:

    Modify __atapi_pio_bytes() to make the "if condition"
more robust, in case of something like (bytes > qc->nbytes),  (qc->cursg_ofs > sg->length) or
(count > bytes) happens.

Those conditions won't happen in the current libata code. Just to be safe  (paranoid).

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------000901030804070209080208
Content-Type: text/plain;
 name="pio1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio1.diff"

--- linux/drivers/scsi/libata-core.c	2005-08-01 15:35:17.000000000 +0800
+++ 01_pio_ifcond/drivers/scsi/libata-core.c	2005-08-01 15:52:29.000000000 +0800
@@ -2603,7 +2603,7 @@
 	unsigned char *buf;
 	unsigned int offset, count;
 
-	if (qc->curbytes == qc->nbytes - bytes)
+	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
@@ -2624,11 +2624,10 @@
 
 	buf = kmap(page) + offset;
 
-	bytes -= count;
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
-	if (qc->cursg_ofs == sg->length) {
+	if (qc->cursg_ofs >= sg->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2640,7 +2639,9 @@
 
 	kunmap(page);
 
-	if (bytes) {
+	if (bytes > count) {
+		bytes -= count;
+
 		goto next_sg;
 	}
 }

--------------000901030804070209080208--


