From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/2] libata: ata_pio_task() accessing 'ap->pio_task_state'
 fix
Date: Wed, 07 Sep 2005 01:41:10 -0400
Message-ID: <431E7D76.60003@pobox.com>
References: <43187433.9080204@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070202040001050605070108"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750703AbVIGFlQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 01:41:16 -0400
In-Reply-To: <43187433.9080204@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------070202040001050605070108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Albert Lee wrote:
> Jeff,
> 
> During PIO, after calling ata_poll_qc_complete(), the next command might be
> running and the value of 'ap->pio_task_state' might have been changed.
> Accessing 'ap->pio_task_state' is not safe at this point.
> 
> Ex.
> qc 1 completed. queuing a final task with ap->pio_task_state == 
> PIO_ST_IDLE.
> qc 2 started, queuing a new task with ap->pio_task_state set to PIO_ST.
> qc 1 read ap->pio_task_state as PIO_ST; not PIO_ST_IDLE as expected.
> => 2 qc running in the workqueue with pio_task_state PIO_ST.
> 
> Changes:
>  1/2: Modify ata_pio_complete() and ata_pio_block() to return
>       whether qc has been completed.
> 
>  2/2: Modify ata_pio_task() to check the return value. Only queue next 
> step and
>        access 'ap->pio_task_state' if the command is not completed.

I would prefer something more like the attached patch.  This patch does 
two things:
* eliminate needless queueing
* don't race with qc-complete in ata_pio_complete()

This patch is COMPLETELY UNTESTED.  Please use the attached as a base, 
to replace the patch series you have submitted.  I won't check it in, as 
I would like to hear feedback and get some review.

	Jeff



--------------070202040001050605070108
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2467,7 +2467,7 @@ static unsigned long ata_pio_poll(struct
  *	None.  (executing in kernel thread context)
  */
 
-static void ata_pio_complete (struct ata_port *ap)
+static int ata_pio_complete (struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 drv_stat;
@@ -2486,14 +2486,14 @@ static void ata_pio_complete (struct ata
 		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
 			ap->pio_task_state = PIO_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return;
+			return 0;
 		}
 	}
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
 		ap->pio_task_state = PIO_ST_ERR;
-		return;
+		return 0;
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -2502,6 +2502,10 @@ static void ata_pio_complete (struct ata
 	ap->pio_task_state = PIO_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat);
+
+	/* another command may start at this point */
+
+	return 1;
 }
 
 
@@ -2887,7 +2891,12 @@ static void ata_pio_error(struct ata_por
 static void ata_pio_task(void *_data)
 {
 	struct ata_port *ap = _data;
-	unsigned long timeout = 0;
+	unsigned long timeout;
+	int qc_completed;
+
+fsm_start:
+	timeout = 0;
+	qc_completed = 0;
 
 	switch (ap->pio_task_state) {
 	case PIO_ST_IDLE:
@@ -2898,7 +2907,7 @@ static void ata_pio_task(void *_data)
 		break;
 
 	case PIO_ST_LAST:
-		ata_pio_complete(ap);
+		qc_completed = ata_pio_complete(ap);
 		break;
 
 	case PIO_ST_POLL:
@@ -2915,8 +2924,8 @@ static void ata_pio_task(void *_data)
 	if (timeout)
 		queue_delayed_work(ata_wq, &ap->pio_task,
 				   timeout);
-	else
-		queue_work(ata_wq, &ap->pio_task);
+	else if (!completed)
+		goto fsm_start;
 }
 
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,

--------------070202040001050605070108--
