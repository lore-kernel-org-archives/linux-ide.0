From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC 4/5] libata-dev: Convert ata_pio_task() to use the
 new ata_hsm_move()
Date: Fri, 10 Mar 2006 22:25:51 +0800
Message-ID: <44118C6F.5050900@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com> <440FED5C.1010503@tw.ibm.com> <20060310093537.GD20207@htj.dyndns.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:61870 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751267AbWCJOZ5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 09:25:57 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2AEPnek009450
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 09:25:49 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2AESeQP191724
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 07:28:40 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2AEPmPC028377
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 07:25:48 -0700
In-Reply-To: <20060310093537.GD20207@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> On Thu, Mar 09, 2006 at 04:54:52PM +0800, Albert Lee wrote:
> 
>>--- 03_support_wq/drivers/scsi/libata-core.c	2006-03-09 15:14:00.000000000 +0800
>>+++ 04_pio_task/drivers/scsi/libata-core.c	2006-03-09 15:14:41.000000000 +0800
>>@@ -725,6 +725,8 @@ static unsigned int ata_pio_modes(const 
>> static inline void
>> ata_queue_pio_task(struct ata_port *ap)
>> {
>>+	ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
>>+
>> 	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
>> 		queue_work(ata_wq, &ap->pio_task);
>> }
> 
> 
> I don't think we really need pio_task_timeout.  Generic EH now handles
> polling timeouts correctly and I can't see any advantage of
> pio_task_timeout.
> 

Ok, will remove pio_task_timeout and the HSM_ST_TMOUT state in the
follow-up patch if Jeff also agree.

> 
>>@@ -3804,44 +3806,55 @@ fsm_start:
>> static void ata_pio_task(void *_data)
>> {
>> 	struct ata_port *ap = _data;
>>-	unsigned long timeout;
>>-	int has_next;
>>+	struct ata_queued_cmd *qc;
>>+	u8 status;
>>+	int poll_next;
>> 
>> fsm_start:
>>-	timeout = 0;
>>-	has_next = 1;
>>+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
>> 
>>-	switch (ap->hsm_task_state) {
>>-	case HSM_ST_FIRST:
>>-		has_next = ata_pio_first_block(ap);
>>-		break;
>>+	qc = ata_qc_from_tag(ap, ap->active_tag);
>>+	WARN_ON(qc == NULL);
>> 
>>-	case HSM_ST:
>>-		ata_pio_block(ap);
>>-		break;
>>+	/*
>>+	 * This is purely heuristic.  This is a fast path.
>>+	 * Sometimes when we enter, BSY will be cleared in
>>+	 * a chk-status or two.  If not, the drive is probably seeking
>>+	 * or something.  Snooze for a couple msecs, then
>>+	 * chk-status again.  If still busy, timeout or queue delayed work.
>>+	 */
>>+	status = ata_busy_wait(ap, ATA_BUSY, 5);
>>+	if (status & ATA_BUSY) {
>>+		msleep(2);
>>+		status = ata_busy_wait(ap, ATA_BUSY, 10);
>>+		if (status & ATA_BUSY) {
>>+			if (time_before(jiffies, ap->pio_task_timeout)) {
>>+				ata_queue_delayed_pio_task(ap, ATA_SHORT_PAUSE);
>>+				return;
>>+			}
>> 
>>-	case HSM_ST_LAST:
>>-		has_next = ata_pio_complete(ap);
>>-		break;
>>+			/* timeout. Let EH handle it later. 
>>+			 * FIXME: should we remove ap->pio_task_timeout?
>>+			 */
>>+			printk(KERN_ERR "ata%u: polling time out\n", ap->id);
>>+			qc->err_mask |= AC_ERR_TIMEOUT;
>>+			ap->hsm_task_state = HSM_ST_TMOUT;
>>+			return; 
>>+		}
>>+	}
>> 
>>-	case HSM_ST_POLL:
>>-	case HSM_ST_LAST_POLL:
>>-		timeout = ata_pio_poll(ap);
>>-		break;
>>+	/* FIXME: check if EH is active */
> 
> 
> No, you don't need to.  Generic EH already does the right thing.  No
> need to worry about EH in polling task.
> 

Ok, will remove the comment in the follow-up patch.

--
Albert

