From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/4] irq-pio: simplify if condition in ata_dataout_task()
Date: Fri, 30 Sep 2005 19:11:35 +0800
Message-ID: <433D1D66.3060104@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010903000208010305050308"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:44226 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030275AbVI3LLi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2005 07:11:38 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8UBA6Uk032514
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:10:06 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8UBBWf4441068
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 05:11:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8UBBV3S007053
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 05:11:31 -0600
In-Reply-To: <433D1BC7.6060301@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------010903000208010305050308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 3/4: simplify if condition in ata_dataout_task()

Changes:
- Use if (qc->tf.protocol == ATA_PROT_PIO) instead of 
if(is_atapi_taskfile()) in ata_dataout_task()

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------010903000208010305050308
Content-Type: text/plain;
 name="idpio3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio3.diff"

--- id2/drivers/scsi/libata-core.c	2005-09-30 18:04:29.000000000 +0800
+++ id3/drivers/scsi/libata-core.c	2005-09-30 18:04:42.000000000 +0800
@@ -3994,13 +3994,7 @@ static void ata_dataout_task(void *_data
 	 */
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
-	if (is_atapi_taskfile(&qc->tf)) {
-		/* send CDB */
-		atapi_send_cdb(ap, qc);
-
-		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			queue_work(ata_wq, &ap->pio_task);
-	} else {
+	if (qc->tf.protocol == ATA_PROT_PIO) {
 		/* PIO data out protocol.
 		 * send first data block.
 		 */
@@ -4013,6 +4007,12 @@ static void ata_dataout_task(void *_data
 		ata_altstatus(ap); /* flush */
 
 		/* interrupt handler takes over from here */
+	} else {
+		/* send CDB */
+		atapi_send_cdb(ap, qc);
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->pio_task);
 	}
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);

--------------010903000208010305050308--

