From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/4] irq-pio: add comments and cleanup
Date: Fri, 30 Sep 2005 19:07:39 +0800
Message-ID: <433D1C7B.90408@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080800020407020700050708"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63905 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030270AbVI3LHi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2005 07:07:38 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8UB7br7016684
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:07:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8UB7bZQ088532
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:07:37 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j8UB7agA024897
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:07:37 -0400
In-Reply-To: <433D1BC7.6060301@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------080800020407020700050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 1/4: add comments and remove redundant code

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------080800020407020700050708
Content-Type: text/plain;
 name="idpio1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio1.diff"

--- irq-pio/include/linux/libata.h	2005-09-30 10:00:31.000000000 +0800
+++ id1/include/linux/libata.h	2005-09-30 17:49:24.000000000 +0800
@@ -158,15 +158,16 @@ enum {
 };
 
 enum hsm_task_states {
-	HSM_ST_UNKNOWN,
-	HSM_ST_IDLE,
-	HSM_ST_POLL,
-	HSM_ST_TMOUT,
-	HSM_ST,
-	HSM_ST_LAST,
-	HSM_ST_LAST_POLL,
-	HSM_ST_ERR,
-	HSM_ST_FIRST,
+	HSM_ST_UNKNOWN,		/* state unknown */
+	HSM_ST_IDLE,		/* no command on going */
+	HSM_ST_POLL,		/* same as HSM_ST, waits longer */
+	HSM_ST_TMOUT,		/* timeout */
+	HSM_ST,			/* (waiting the device to) transfer data */
+	HSM_ST_LAST,		/* (waiting the device to) complete command */
+	HSM_ST_LAST_POLL,	/* same as HSM_ST_LAST, waits longer */
+	HSM_ST_ERR,		/* error */
+	HSM_ST_FIRST,		/* (waiting the device to)
+				   write CDB or first data block */
 };
 
 /* forward declarations */
--- irq-pio/drivers/scsi/libata-core.c	2005-09-30 10:00:04.000000000 +0800
+++ id1/drivers/scsi/libata-core.c	2005-09-30 14:31:28.000000000 +0800
@@ -3430,18 +3430,6 @@ int ata_qc_issue_prot(struct ata_queued_
 		break;
 
 	case ATA_PROT_ATAPI:
-		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
-
-		ata_tf_to_host_nolock(ap, &qc->tf);
-		ap->hsm_task_state = HSM_ST_FIRST;
-
-		/* send cdb by polling if no cdb interrupt */
-		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
-		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			queue_work(ata_wq, &ap->packet_task);
-		break;
-
 	case ATA_PROT_ATAPI_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);

--------------080800020407020700050708--

