From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata: ata_pio_task() fix
Date: Fri, 02 Sep 2005 23:55:34 +0800
Message-ID: <431875F6.8080808@tw.ibm.com>
References: <43187433.9080204@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090109040401060907000602"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.133]:37012 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750705AbVIBPzt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Sep 2005 11:55:49 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j82FtecJ115772
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 11:55:40 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j82FteRK535862
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 09:55:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j82Ftdep025273
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 09:55:40 -0600
In-Reply-To: <43187433.9080204@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------090109040401060907000602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

PATCH 2/2:
Modify ata_pio_task() to check the return value of patch 1/2
before queuing next step and using the value of 'ap->pio_task_state'.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------090109040401060907000602
Content-Type: text/plain;
 name="pio2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio2.diff"

--- pio1/drivers/scsi/libata-core.c	2005-09-02 18:37:26.000000000 +0800
+++ pio2/drivers/scsi/libata-core.c	2005-09-02 18:37:19.000000000 +0800
@@ -2893,21 +2893,20 @@
 {
 	struct ata_port *ap = _data;
 	unsigned long timeout = 0;
+	int has_next = 0;
 
 	switch (ap->pio_task_state) {
-	case PIO_ST_IDLE:
-		return;
-
 	case PIO_ST:
-		ata_pio_block(ap);
+		has_next = ata_pio_block(ap);
 		break;
 
 	case PIO_ST_LAST:
-		ata_pio_complete(ap);
+		has_next = ata_pio_complete(ap);
 		break;
 
 	case PIO_ST_POLL:
 	case PIO_ST_LAST_POLL:
+		has_next = 1;
 		timeout = ata_pio_poll(ap);
 		break;
 
@@ -2915,13 +2914,18 @@
 	case PIO_ST_ERR:
 		ata_pio_error(ap);
 		return;
+	default:
+		printk(KERN_ERR "ata%u unknown PIO task state %u\n", 
+		       ap->id, ap->pio_task_state);
+		return;
 	}
 
-	if (timeout)
-		queue_delayed_work(ata_wq, &ap->pio_task,
-				   timeout);
-	else
-		queue_work(ata_wq, &ap->pio_task);
+	if (has_next) {
+		if (timeout)
+			queue_delayed_work(ata_wq, &ap->pio_task, timeout);
+		else
+			queue_work(ata_wq, &ap->pio_task);
+	}
 }
 
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,

--------------090109040401060907000602--

