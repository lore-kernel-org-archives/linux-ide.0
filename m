From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH libata-2.6 3/5] __atapi_pio_bytes() if condition enhancement
Date: Fri, 18 Mar 2005 15:49:39 +0800
Message-ID: <423A8813.3020507@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080803050402000406010200"
Received: from bluehawaii.tikira.net ([61.62.22.51]:2533 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261484AbVCRHt6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Mar 2005 02:49:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080803050402000406010200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   In __atapi_pio_bytes(), when (bytes > qc->nbytes) or (qc->cursg_ofs > sg->length) or
(count > bytes), the condition is not handled properly.

Changes:
- Fix the if condition mentioned above.

   Attached please find the patch against the libata-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
--- libata-2.6-atapi_pio_bytes/drivers/scsi/libata-core.c	2005-03-18 13:20:01.000000000 +0800
+++ libata-2.6-reorder/drivers/scsi/libata-core.c	2005-03-18 12:56:44.000000000 +0800
@@ -2334,7 +2334,7 @@
  	unsigned char *buf;
  	unsigned int offset, count;

-	if (qc->curbytes == qc->nbytes - bytes)
+	if (qc->curbytes + bytes >= qc->nbytes)
  		ap->pio_task_state = PIO_ST_LAST;

  next_sg:
@@ -2355,11 +2355,10 @@

  	buf = kmap(page) + offset;

-	bytes -= count;
  	qc->curbytes += count;
  	qc->cursg_ofs += count;

-	if (qc->cursg_ofs == sg->length) {
+	if (qc->cursg_ofs >= sg->length) {
  		qc->cursg++;
  		qc->cursg_ofs = 0;
  	}
@@ -2371,7 +2370,9 @@

  	kunmap(page);

-	if (bytes) {
+	if (bytes > count) {
+		bytes -= count;
+
  		goto next_sg;
  	}
  }


--------------080803050402000406010200
Content-Type: text/plain;
 name="reorder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reorder.diff"

--- libata-2.6-atapi_pio_bytes/drivers/scsi/libata-core.c	2005-03-18 13:20:01.000000000 +0800
+++ libata-2.6-reorder/drivers/scsi/libata-core.c	2005-03-18 12:56:44.000000000 +0800
@@ -2334,7 +2334,7 @@
 	unsigned char *buf;
 	unsigned int offset, count;
 
-	if (qc->curbytes == qc->nbytes - bytes)
+	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
@@ -2355,11 +2355,10 @@
 
 	buf = kmap(page) + offset;
 
-	bytes -= count;
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
-	if (qc->cursg_ofs == sg->length) {
+	if (qc->cursg_ofs >= sg->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2371,7 +2370,9 @@
 
 	kunmap(page);
 
-	if (bytes) {
+	if (bytes > count) {
+		bytes -= count;
+
 		goto next_sg;
 	}
 }

--------------080803050402000406010200--


