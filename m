From: Albert Lee <albertcc@tw.ibm.com>
Subject: PATCH libata-2.6 4/5] Prevent the device from overrunning the buffer
 in __atapi_pio_bytes()
Date: Fri, 18 Mar 2005 16:00:36 +0800
Message-ID: <423A8AA4.5040601@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050205090105060807030905"
Received: from bluehawaii.tikira.net ([61.62.22.51]:11749 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261487AbVCRIA6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Mar 2005 03:00:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050205090105060807030905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   Some bad behaved CD-ROM drives will return more data than ask to.
(I have such CD-RW drive and it crashed the kernel.)

Changes:
- Add additional check in __atapi_pio_bytes() to prevent the device from overrunning the buffer.

Attached please find the patch against the libata-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
--- libata-2.6-reorder/drivers/scsi/libata-core.c	2005-03-18 12:56:44.000000000 +0800
+++ libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-18 14:00:34.000000000 +0800
@@ -2338,6 +2338,14 @@
  		ap->pio_task_state = PIO_ST_LAST;

  next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		printk(KERN_WARNING "ata%u: qc->sg full, %u bytes trailing\n", ap->id, bytes);
+
+		ap->pio_task_state = PIO_ST_ERR;
+		return;
+	}
+
  	sg = &qc->sg[qc->cursg];

  	page = sg->page;


--------------050205090105060807030905
Content-Type: text/plain;
 name="extrabytes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extrabytes.diff"

--- libata-2.6-reorder/drivers/scsi/libata-core.c	2005-03-18 12:56:44.000000000 +0800
+++ libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-18 14:00:34.000000000 +0800
@@ -2338,6 +2338,14 @@
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	/* check whether qc->sg is full */
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		printk(KERN_WARNING "ata%u: qc->sg full, %u bytes trailing\n", ap->id, bytes);
+
+		ap->pio_task_state = PIO_ST_ERR;
+		return;
+	}
+
 	sg = &qc->sg[qc->cursg];
 
 	page = sg->page;

--------------050205090105060807030905--


