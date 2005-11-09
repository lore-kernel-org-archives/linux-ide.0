From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/3] libata: check qc->err_mask for the internal commands
Date: Wed, 09 Nov 2005 13:12:03 +0800
Message-ID: <43718523.1000408@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:40418 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030504AbVKIFMN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2005 00:12:13 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA95C5ls001980
	for <linux-ide@vger.kernel.org>; Wed, 9 Nov 2005 00:12:05 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jA95DG1K050340
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 22:13:16 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA95C5HY004257
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 22:12:05 -0700
In-Reply-To: <437181D5.8070903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 3/3:
  check qc->err_mask for the internal commands.

Problem:
  The results of internal commands issued by libata itself were not checked.

  For example, ata_dev_identify() only checks the device status (qc->tf.command).
  However, checking the device status is not enough to detect all errors.

Changes:
  - check qc->err_mask for the internal commands:
    - ata_dev_identify()
    - ata_dev_set_xfermode()
    - ata_dev_reread_id()
    - ata_dev_init_params() 
    - atapi_request_sense()

The patch accesses qc (and ap) after the qc is completed.
This is bad from the object life cycle point of view and might cause race.
However, since libata has complete control over the hardware when libata issues the internal commands
and it seems noboby else may issue command at the same time, 
accessing qc after ata_qc_complete() looks to be ok here.

p.s. 
     The patch above can also make ata_dev_identify() detect the
     "phantom slave device" problem.

     The "phantom slave device" was seen in specific PATA master-only configuration.
     The master device responds to some commands issued to the slave device, and
     make a illusion that the slave device exists.
     The device status register of the "phantom slave device" always read as zero.
     So, using (qc->tf.command & ATA_ERR) cannot detect the error.
     Checking qc->err_mask can make ata_dev_identify() detect such 
     "phantom slave device" and exclude the phantom device.

For your review and advice, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============
--- err_mask/drivers/scsi/libata-core.c	2005-11-09 10:15:33.000000000 +0800
+++ phantom/drivers/scsi/libata-core.c	2005-11-09 10:15:54.000000000 +0800
@@ -1132,7 +1132,7 @@ retry:
 	ap->ops->tf_read(ap, &qc->tf);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	if (qc->tf.command & ATA_ERR) {
+	if (qc->err_mask) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1144,8 +1144,10 @@ retry:
 		 * ATA software reset (SRST, the default) does not appear
 		 * to have this problem.
 		 */
-		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
+		if ((using_edd) && (dev->class == ATA_DEV_ATA) &&
+		    (qc->tf.command & ATA_ERR)) {
 			u8 err = qc->tf.feature;
+
 			if (err & ATA_ABORTED) {
 				dev->class = ATA_DEV_ATAPI;
 				qc->cursg = 0;
@@ -2267,11 +2269,19 @@ static void ata_dev_set_xfermode(struct 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+		goto err_out;
+
+	wait_for_completion(&wait);
+
+	if (qc->err_mask)
+		goto err_out;
 
 	DPRINTK("EXIT\n");
+
+	return;
+err_out:
+	printk(KERN_ERR "ata%u: set XFER MODE failed\n", ap->id);
+	ata_port_disable(ap);
 }
 
 /**
@@ -2319,6 +2329,9 @@ static void ata_dev_reread_id(struct ata
 
 	wait_for_completion(&wait);
 
+	if (qc->err_mask)
+		goto err_out;
+
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	ata_dump_id(dev);
@@ -2327,6 +2340,7 @@ static void ata_dev_reread_id(struct ata
 
 	return;
 err_out:
+	printk(KERN_ERR "ata%u: reread IDENTIFY device data failed\n", ap->id);
 	ata_port_disable(ap);
 }
 
@@ -2371,11 +2385,19 @@ static void ata_dev_init_params(struct a
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+		goto err_out;
+
+	wait_for_completion(&wait);
+
+	if (qc->err_mask)
+		goto err_out;
 
 	DPRINTK("EXIT\n");
+
+	return;
+err_out:
+	printk(KERN_ERR "ata%u: init CHS dev params failed\n", ap->id);
+	ata_port_disable(ap);
 }
 
 /**
--- err_mask/drivers/scsi/libata-scsi.c	2005-11-08 16:25:51.000000000 +0800
+++ phantom/drivers/scsi/libata-scsi.c	2005-11-09 10:37:39.000000000 +0800
@@ -2008,11 +2008,19 @@ void atapi_request_sense(struct ata_port
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+		goto err_out;
+
+	wait_for_completion(&wait);
+
+	if (qc->err_mask)
+		goto err_out;
 
 	DPRINTK("EXIT\n");
+
+	return;
+err_out:
+	printk(KERN_ERR "ata%u: atapi request sense failed\n", ap->id);
+	ata_port_disable(ap);
 }
 
 static int atapi_qc_complete(struct ata_queued_cmd *qc)



