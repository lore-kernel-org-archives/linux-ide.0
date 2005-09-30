From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC 3/4] libata: interrupt driven pio for libata-core
Date: Fri, 30 Sep 2005 16:02:53 +0800
Message-ID: <433CF12D.900@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:19346 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030260AbVI3IDI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2005 04:03:08 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8U81bbN018853
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 04:01:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8U832f4500494
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 02:03:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8U831Ys001464
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 02:03:02 -0600
In-Reply-To: <58cb370e05092903083e0d001c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Hi Bart:

>Hi,
>
>On 9/27/05, Albert Lee <albertcc@tw.ibm.com> wrote:
>  
>
>>Patch 3/4: interrupt driven pio for libata-core
>>
>>Changes:
>>- add PIO_ST_FIRST for the state before sending ATAPI CDB or sending
>>    
>>
>
>HSM_ST_FIRST
>
>Could you add some brief comments about HSM_* states
>(one line per state should be OK)?
>  
>
Hmm, will add the comments in the follow up patch.

>  
>
>>@@ -3344,43 +3356,96 @@ int ata_qc_issue_prot(struct ata_queued_
>> {
>>        struct ata_port *ap = qc->ap;
>>
>>+               } else {
>>+                       /* interrupt driven PIO */
>>+                       if (qc->tf.flags & ATA_TFLAG_WRITE) {
>>+                               /* PIO data out protocol */
>>+                               ap->hsm_task_state = HSM_ST_FIRST;
>>+                               queue_work(ata_wq, &ap->packet_task);
>>    
>>
>
>atapi_packet_task() is now abused to do ATA PIO out which is
>very confusing given that name of the function (and all the comments)
>remains unchanged.  Please correct it (I think it would be good idea to
>separate HSM_ST_CDB from HSM_ST_FIRST).
>  
>

You're right, will rename the atapi_packet_task() and revise the related 
variable and comments.

HSM_ST_CDB and HSM_ST_FIRST are almost the same except the content of 
the data being sent.
Could we keep them as one state?

>  
>
>>        case ATA_PROT_ATAPI:
>>-               ata_qc_set_polling(qc);
>>+               if (qc->tf.flags & ATA_TFLAG_POLLING)
>>+                       ata_qc_set_polling(qc);
>>+
>>                ata_tf_to_host_nolock(ap, &qc->tf);
>>-               queue_work(ata_wq, &ap->packet_task);
>>+               ap->hsm_task_state = HSM_ST_FIRST;
>>+
>>+               /* send cdb by polling if no cdb interrupt */
>>+               if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
>>+                   (qc->tf.flags & ATA_TFLAG_POLLING))
>>+                       queue_work(ata_wq, &ap->packet_task);
>>                break;
>>
>>        case ATA_PROT_ATAPI_NODATA:
>>-               ap->flags |= ATA_FLAG_NOINTR;
>>+               if (qc->tf.flags & ATA_TFLAG_POLLING)
>>+                       ata_qc_set_polling(qc);
>>+
>>                ata_tf_to_host_nolock(ap, &qc->tf);
>>-               queue_work(ata_wq, &ap->packet_task);
>>+               ap->hsm_task_state = HSM_ST_FIRST;
>>+
>>+               /* send cdb by polling if no cdb interrupt */
>>+               if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
>>+                   (qc->tf.flags & ATA_TFLAG_POLLING))
>>+                       queue_work(ata_wq, &ap->packet_task);
>>                break;
>>    
>>
>
>ATA_PROT_ATAPI_NODATA case is now identical
>to ATA_PROT_ATAPI one - no need to duplicate code.
>
>It may be also worth to split ata_qc_issue_prot() on IRQ
>and polling versions because it is really hard to read now.
>  
>
Nice catch, will remove the redundant code.
will also cleanup the ata_qc_issue_prot() code to simplify the PIO data 
out codepath.
(Hopefully the simplified ata_qc_issue_prot() is easier to read and we 
could have one version for both polling and IRQ version.)

>  
>
>>+/**
>>  *     ata_host_intr - Handle host interrupt for given (port, task)
>>  *     @ap: Port on which interrupt arrived (possibly...)
>>  *     @qc: Taskfile currently active in engine
>>@@ -3641,47 +3742,142 @@ void ata_bmdma_stop(struct ata_queued_cm
>> inline unsigned int ata_host_intr (struct ata_port *ap,
>>                                   struct ata_queued_cmd *qc)
>> {
>>    
>>
>
>We should check first if we are polling and if so we shouldn't touch hardware
>et all as we can interface with ata_pio_task or atapi_packet_task.  Just think
>about HSM_ST case when hardware is ready for the next transfer and IRQ
>happens (from some other device).
>
>Please note that this bug is present in original libata code.
>
>  
>
The (qc->tf.flags & ATA_TFLAG_POLLING) flag is checked in ata_interrupt().
So, the race between the irq handler and ata_pio_task() is avoided.

When the state is HSM_ST_FIRST,  ata_host_intr() checks the 
(qc->dev->flags & ATA_DFLAG_CDB_INTR) flag.
Also in atapi_packet_task(), the host lock is aquired during the state 
transition from HSM_ST_FIRST to next state.
So, the race between the irq handler and atapi_packet_task() is avoided.

>>-       u8 status, host_stat;
>>-
>>-       switch (qc->tf.protocol) {
>>+       u8 status, host_stat = 0;
>>
>>-       case ATA_PROT_DMA:
>>-       case ATA_PROT_ATAPI_DMA:
>>-       case ATA_PROT_ATAPI:
>>    
>>
>
>Your patch changes behavior for ATA_PROT_ATAPI case - now DMA
>engine won't be checked.  We had discussion about fixing it before
>but I don't remember what was the conclusion - in any case it is worth
>to at least mention this change in the patch description.
>
>  
>

Sorry I forgot to mention it in the description of previous patch
For the ATA_PROT_ATAPI case, the behavior is changed in the irq handler:
  - The DMA status register is no longer checked.
  - HSM state and device busy flag are used together to see whether it 
is our irq or not.

This new behavior seems to be working ok on my test machine.
However, not sure whether this 100% works on all hardware.
Need more test and comment.

>>-               /* check status of DMA engine */
>>-               host_stat = ap->ops->bmdma_status(ap);
>>-               VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
>>+       VPRINTK("ata%u: protocol %d task_state %d\n",
>>+               ap->id, qc->tf.protocol, ap->hsm_task_state);
>>
>>-               /* if it's not our irq... */
>>-               if (!(host_stat & ATA_DMA_INTR))
>>+       /* Check whether we are expecting interrupt in this state */
>>+       switch (ap->hsm_task_state) {
>>+       case HSM_ST_FIRST:
>>+               /* Check the ATA_DFLAG_CDB_INTR flag is enough here.
>>+                * The flag was turned on only for atapi devices.
>>+                * No need to check is_atapi_taskfile(&qc->tf) again.
>>+                */
>>+               if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>>                        goto idle_irq;
>>+               break;
>>... (snip) ...
>>+
>>+
>>+fsm_start:
>>+       switch (ap->hsm_task_state) {
>>+       case HSM_ST_FIRST:
>>+               /* Some pre-ATAPI-4 devices assert INTRQ
>>+                * at this state when ready to receive CDB.
>>+                */
>>+
>>+               /* check device status */
>>+               if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
>>+                       /* Wrong status. Let EH handle this */
>>+                       ap->hsm_task_state = HSM_ST_ERR;
>>+                       goto fsm_start;
>>+               }
>>+
>>+               atapi_send_cdb(ap, qc);
>>    
>>
>
>This case can happen also for ATA PIO out:
>ata_qc_issue_prot() -> IRQ happens -> ata_host_intr().
>
>Sending CDB unconditionally is wrong.
>
>
>  
>
The (qc->dev->flags & ATA_DFLAG_CDB_INTR) flag is only turned on for 
atapi devices.
So, when we are in the HSM_ST_FIRST state, ATA devices are filtered out 
and won't enter the irq handler.


Thanks for the review and advice, will revise and send follow up patch 
later.
(Will also have look at the READ/WRITE MULTIPLE mentioned by Jeff.)

Albert



