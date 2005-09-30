From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 4/4] irq-pio: cleanup ata_qc_issue_prot()
Date: Fri, 30 Sep 2005 19:14:19 +0800
Message-ID: <433D1E0B.70807@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060305040100050508050608"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:62944 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030277AbVI3LOW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2005 07:14:22 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8UBDbbS005629
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:13:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8UBEGf4500032
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 05:14:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8UBEFLi009746
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 05:14:16 -0600
In-Reply-To: <433D1BC7.6060301@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------060305040100050508050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 4/4: cleanup ata_qc_issue_prot()

Changes:
ata_qc_issue_prot():
    - cleanup and let the PIO data out case always go through the 
ata_dataout_task() codepath.
      (Previously for PIO data out case, 2 code pathes were used
        - irq case goes through ata_data_out_task() codepath.
        - polling case jumps over the HSM_ST_FIRST state and goes to 
HSM_ST and ata_pio_task() directly.)

  ata_dataout_task():
    - rearrange the queue_work() code to handle the PIO data out + 
polling case.


For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------060305040100050508050608
Content-Type: text/plain;
 name="idpio4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio4.diff"

--- id3/drivers/scsi/libata-core.c	2005-09-30 18:04:42.000000000 +0800
+++ id4/drivers/scsi/libata-core.c	2005-09-30 18:04:33.000000000 +0800
@@ -3407,24 +3407,24 @@ int ata_qc_issue_prot(struct ata_queued_
 
 		ata_tf_to_host_nolock(ap, &qc->tf);
 
-		if (qc->tf.flags & ATA_TFLAG_POLLING) {
-			/* polling PIO */
-			ap->hsm_task_state = HSM_ST;
-			queue_work(ata_wq, &ap->pio_task);
+		if (qc->tf.flags & ATA_TFLAG_WRITE) {
+			/* PIO data out protocol */
+			ap->hsm_task_state = HSM_ST_FIRST;
+			queue_work(ata_wq, &ap->dataout_task);
+
+			/* always send first data block using
+			 * the ata_dataout_task() codepath.
+			 */
 		} else {
-			/* interrupt driven PIO */
-			if (qc->tf.flags & ATA_TFLAG_WRITE) {
-				/* PIO data out protocol */
-				ap->hsm_task_state = HSM_ST_FIRST;
-				queue_work(ata_wq, &ap->dataout_task);
-
-				/* send first data block by polling */
-			} else {
-				/* PIO data in protocol */
-				ap->hsm_task_state = HSM_ST;
+			/* PIO data in protocol */
+			ap->hsm_task_state = HSM_ST;
 
-				/* interrupt handler takes over from here */
-			}
+			if (qc->tf.flags & ATA_TFLAG_POLLING)
+				queue_work(ata_wq, &ap->pio_task);
+
+			/* if polling, ata_pio_task() handles the rest.
+			 * otherwise, interrupt handler takes over from here.
+			 */
 		}
 
 		break;
@@ -4005,15 +4005,15 @@ static void ata_dataout_task(void *_data
 		ap->hsm_task_state = HSM_ST;
 		ata_pio_sector(qc);
 		ata_altstatus(ap); /* flush */
-
-		/* interrupt handler takes over from here */
-	} else {
+	} else
 		/* send CDB */
 		atapi_send_cdb(ap, qc);
 
-		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			queue_work(ata_wq, &ap->pio_task);
-	}
+	/* if polling, ata_pio_task() handles the rest.
+	 * otherwise, interrupt handler takes over from here.
+	 */
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		queue_work(ata_wq, &ap->pio_task);
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 

--------------060305040100050508050608--

