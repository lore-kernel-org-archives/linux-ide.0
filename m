From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 0/2] libata: ata_pio_task() accessing 'ap->pio_task_state'
 fix
Date: Wed, 07 Sep 2005 18:03:03 +0800
Message-ID: <431EBAD7.40801@tw.ibm.com>
References: <43187433.9080204@tw.ibm.com> <431E7D76.60003@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090607020603060000050600"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9346 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932097AbVIGKDR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 06:03:17 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j87A3Cm1020175
	for <linux-ide@vger.kernel.org>; Wed, 7 Sep 2005 06:03:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j87A3COt096520
	for <linux-ide@vger.kernel.org>; Wed, 7 Sep 2005 06:03:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j87A3Bs0015609
	for <linux-ide@vger.kernel.org>; Wed, 7 Sep 2005 06:03:12 -0400
In-Reply-To: <431E7D76.60003@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------090607020603060000050600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

> Albert Lee wrote:
>
>> Jeff,
>>
>> During PIO, after calling ata_poll_qc_complete(), the next command 
>> might be
>> running and the value of 'ap->pio_task_state' might have been changed.
>> Accessing 'ap->pio_task_state' is not safe at this point.
>>
>> Ex.
>> qc 1 completed. queuing a final task with ap->pio_task_state == 
>> PIO_ST_IDLE.
>> qc 2 started, queuing a new task with ap->pio_task_state set to PIO_ST.
>> qc 1 read ap->pio_task_state as PIO_ST; not PIO_ST_IDLE as expected.
>> => 2 qc running in the workqueue with pio_task_state PIO_ST.
>>
>> Changes:
>>  1/2: Modify ata_pio_complete() and ata_pio_block() to return
>>       whether qc has been completed.
>>
>>  2/2: Modify ata_pio_task() to check the return value. Only queue 
>> next step and
>>        access 'ap->pio_task_state' if the command is not completed.
>
>
> I would prefer something more like the attached patch.  This patch 
> does two things:
> * eliminate needless queueing
> * don't race with qc-complete in ata_pio_complete()

The patch looks good and clearer. :)

Only one minor addition for your review:

* ata_pio_block() changed to go to PIO_ST_LAST state, instead of
   going to PIO_ST_IDLE state directly and calling ata_poll_qc_complete().

i.e.
@@ -2845,9 +2852,7 @@
     if (is_atapi_taskfile(&qc->tf)) {
         /* no more data to transfer or unsupported ATAPI command */
         if ((status & ATA_DRQ) == 0) {
-            ap->pio_task_state = PIO_ST_IDLE;
-
-            ata_poll_qc_complete(qc, status);
+            ap->pio_task_state = PIO_ST_LAST;
             return;
         }

This is needed since ata_pio_block() might complete the qc.
This can also make the pio polling code go through the 
ata_pio_complete(), making the state transition explicit.

Attached please find the revised patch for your review.
(Patched for 2.6.13  80ac2912f846c01d702774bb6aa7100ec71e88b9).

>
> This patch is COMPLETELY UNTESTED.  Please use the attached as a base, 
> to replace the patch series you have submitted.  I won't check it in, 
> as I would like to hear feedback and get some review.
>

Tested ok on x86 PC. Will test on the big machines later.

Albert

(Revision based on Jeff's patch)
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>




--------------090607020603060000050600
Content-Type: text/plain;
 name="pio_poll.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio_poll.diff"

--- linux/drivers/scsi/libata-core.c.ori	2005-09-02 17:59:15.000000000 +0800
+++ pio_poll/drivers/scsi/libata-core.c	2005-09-07 16:18:00.000000000 +0800
@@ -2461,9 +2461,12 @@
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
+ *
+ *	RETURNS:
+ *	Non-zero if qc completed, zero otherwise.
  */
 
-static void ata_pio_complete (struct ata_port *ap)
+static int ata_pio_complete (struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 drv_stat;
@@ -2482,14 +2485,14 @@
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
@@ -2498,6 +2501,10 @@
 	ap->pio_task_state = PIO_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat);
+
+	/* another command may start at this point */
+
+	return 1;
 }
 
 
@@ -2845,9 +2852,7 @@
 	if (is_atapi_taskfile(&qc->tf)) {
 		/* no more data to transfer or unsupported ATAPI command */
 		if ((status & ATA_DRQ) == 0) {
-			ap->pio_task_state = PIO_ST_IDLE;
-
-			ata_poll_qc_complete(qc, status);
+			ap->pio_task_state = PIO_ST_LAST;
 			return;
 		}
 
@@ -2883,7 +2888,12 @@
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
@@ -2894,7 +2904,7 @@
 		break;
 
 	case PIO_ST_LAST:
-		ata_pio_complete(ap);
+		qc_completed = ata_pio_complete(ap);
 		break;
 
 	case PIO_ST_POLL:
@@ -2909,10 +2919,9 @@
 	}
 
 	if (timeout)
-		queue_delayed_work(ata_wq, &ap->pio_task,
-				   timeout);
-	else
-		queue_work(ata_wq, &ap->pio_task);
+		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
+	else if (likely(!qc_completed))
+		goto fsm_start;
 }
 
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,

--------------090607020603060000050600--

