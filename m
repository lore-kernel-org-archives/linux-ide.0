From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC 3/5] libata-dev: Let ata_hsm_move() work with both
 irq-pio and polling pio
Date: Fri, 10 Mar 2006 21:52:54 +0800
Message-ID: <441184B6.9060302@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com> <440FEC98.4010500@tw.ibm.com> <20060310093128.GC20207@htj.dyndns.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:65417 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751103AbWCJNxg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 08:53:36 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2ADrRfX029539
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:53:27 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2ADuJQP161650
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 06:56:19 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2ADrQ4g009723
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 06:53:27 -0700
In-Reply-To: <20060310093128.GC20207@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> On Thu, Mar 09, 2006 at 04:51:36PM +0800, Albert Lee wrote:
> [--- snip ---]
> 
>>+
>>+static int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>>+			u8 status, int in_wq)
> 
> 
> IMHO, polling would be a slightly better name than in_wq.
> 
> 

The "in_wq" name helps to differ it from (qc->tf.flags & ATA_TFLAG_POLLING).

>> {
>>+	unsigned long flags = 0;
>>+	int poll_next;
>>+
>> 	WARN_ON(qc == NULL);
>> 	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
>> 
>>+	WARN_ON(in_wq != ((qc->tf.flags & ATA_TFLAG_POLLING) ||
>>+			  (ap->hsm_task_state == HSM_ST_FIRST &&
>>+			   ((qc->tf.protocol == ATA_PROT_PIO &&
>>+			     (qc->tf.flags & ATA_TFLAG_WRITE)) ||
>>+			    (is_atapi_taskfile(&qc->tf) &&
>>+			     !(qc->dev->flags & ATA_DFLAG_CDB_INTR))))));
>>+
> 
> 
> I think this is a little bit excessive.  Can't we get away with
> WARN_ON(in_wq != !in_irq()) or just trust what the caller says?  It's
> not like this function has a lot of callers.
> 
> 

The check prevents me from doing something stupid to ata_qc_issue_prot(), say,
insert a qc with DMA protocol into the workqueue, etc.
Also it helps to show how in_wq compares with (qc->tf.flags & ATA_TFLAG_POLLING).
(I was once confused when wrote the code.) Will add a comment to make it clear next time.

>> 	/* check error */
>> 	if (unlikely(status & (ATA_ERR | ATA_DF))) {
>> 		qc->err_mask |= AC_ERR_DEV;
>>@@ -3643,6 +3664,13 @@ static void ata_hsm_move(struct ata_port
>> fsm_start:
>> 	switch (ap->hsm_task_state) {
>> 	case HSM_ST_FIRST:
>>+		/* Send first data block or PACKET CDB */
>>+
>>+		/* if polling, we will stay in the work queue after sending the data.
>>+		 * otherwise, interrupt handler takes over after sending the data.
>>+		 */
>>+		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
>>+
>> 		/* check device status */
>> 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
>> 			/* Wrong status. Let EH handle this */
>>@@ -3651,8 +3679,35 @@ fsm_start:
>> 			goto fsm_start;
>> 		}
>> 
>>-		atapi_send_cdb(ap, qc);
>>+		/* Send the CDB (atapi) or the first data block (ata pio out).
>>+		 * During the state transition, interrupt handler shouldn't
>>+		 * be invoked before the data transfer is complete and
>>+		 * hsm_task_state is changed. Hence, the following locking.
>>+		 */
>>+		if (in_wq)
>>+			spin_lock_irqsave(&ap->host_set->lock, flags);
>>+
>>+		if (qc->tf.protocol == ATA_PROT_PIO) {
>>+			/* PIO data out protocol.
>>+			 * send first data block.
>>+			 */
>>+
>>+			/* ata_pio_sectors() might change the state to HSM_ST_LAST.
>>+			 * so, the state is changed here before ata_pio_sectors().
>>+			 */
>>+			ap->hsm_task_state = HSM_ST;
>>+			ata_pio_sectors(qc);
>>+			ata_altstatus(ap); /* flush */
>>+		} else
>>+			/* send CDB */
>>+			atapi_send_cdb(ap, qc);
>> 
>>+		if (in_wq)
>>+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
>>+
>>+		/* if polling, ata_pio_task() handles the rest.
>>+		 * otherwise, interrupt handler takes over from here.
>>+		 */
>> 		break;
>> 
> 
> 
> For ATA PIO write transfers, the first transfer and n'th transfers
> aren't really different.  The code would be simpler if it handles the
> first ATA PIO write in HSM_ST.  And if we do that, HSM_ST_FIRST can be
> renamed to HSM_ST_CDB.  Hmmm.. Maybe this should be done in separate
> series of patches.
> 

For ATA PIO write transfer, the first transfer is different:
It is always done by polling, even if irq is turned on.

If we treat the first PIO write transfer as HSM_ST, we need to add some
additional logic to HSM_ST and check whether it is first transfer or not. If it is,
and irq is on, the transition from polling to interrupt-driven must be protected
by spinlock, similar to what's done in HSM_ST_FIRST.

HSM_ST is more frequent than HSM_ST_FIRST, so treat the first PIO
write transfer as HSM_ST generates more if() execution than
treat the first PIO write transfer as HSM_ST_FIRST and do the if() there.

--
Thanks for the review,

Albert

