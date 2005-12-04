From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: implement ata_exec_internal()
Date: Sun, 04 Dec 2005 14:21:38 -0500
Message-ID: <439341C2.5090205@pobox.com>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:22658 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932293AbVLDTWF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Dec 2005 14:22:05 -0500
In-Reply-To: <4392F78A.2040209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:

>>> This is take #2 of ata_exec_internal().  qc allocation and tf
>>> reading-back have also been moved into ata_exec_internal().  Now all
>>> qc handling is done while properly holding host_set lock removing
>>> above mentioned rare race conditon (the second item).
>>>
>>> Index: work/drivers/scsi/libata-core.c
>>> ===================================================================
>>> --- work.orig/drivers/scsi/libata-core.c    2005-11-29 
>>> 22:04:15.000000000 +0900
>>> +++ work/drivers/scsi/libata-core.c    2005-11-29 22:06:20.000000000 
>>> +0900
>>> @@ -1047,28 +1047,119 @@ static unsigned int ata_pio_modes(const      
>>> return modes;
>>>  }
>>>  
>>> -static int ata_qc_wait_err(struct ata_queued_cmd *qc,
>>> -               struct completion *wait)
>>> +struct ata_exec_internal_arg {
>>> +    unsigned int err_mask;
>>> +    struct ata_taskfile *tf;
>>> +    struct completion *waiting;
>>> +};
>>> +
>>> +int ata_qc_complete_internal(struct ata_queued_cmd *qc, unsigned int 
>>> err_mask)
>>>  {
>>> -    int rc = 0;
>>> +    struct ata_exec_internal_arg *arg = qc->complete_data;
>>
>>
>>
>> This is what private_data is for.  No need to add 'complete_data'.
>>
> 
> Hmmm... As there currently isn't any in-kernel user of qc->private_data, 
> its ownership status isn't very clear.  However, ap->private_data is 
> used by most low-level drivers to store its private data, so I assumed 
> that qc->private_data belongs to low-level driver too.
> 
> Actually, the m15w workaround I'm maintaining uses qc->private_data to 
> store context for qc iteration.  This can be substitued easily but I 
> think it would be nice / more consistent to reserve private_data fields 
> for low-level drivers.

qc->private_data is for the creator/owner of the ata_queued_cmd, not for 
low-level drivers.


>>> +    struct completion *waiting = arg->waiting;
>>>  
>>> -    if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
>>> -        /* timeout handling */
>>> -        unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
>>> -
>>> -        if (!err_mask) {
>>> -            printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
>>> -                   qc->ap->id, qc->tf.command);
>>> -        } else {
>>> -            printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
>>> -                   qc->ap->id, qc->tf.command);
>>> -            rc = -EIO;
>>> -        }
>>> +    if (!(err_mask & ~AC_ERR_DEV))
>>> +        qc->ap->ops->tf_read(qc->ap, arg->tf);
>>> +    arg->err_mask = err_mask;
>>> +    arg->waiting = NULL;
>>> +    complete(waiting);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + *    ata_exec_internal - execute libata internal command
>>> + *    @ap: Port to which the command is sent
>>> + *    @dev: Device to which the command is sent
>>> + *    @tf: Taskfile registers for the command and the result
>>> + *    @dma_dir: Data tranfer direction of the command
>>> + *    @buf: Data buffer of the command
>>> + *    @buflen: Length of data buffer
>>> + *
>>> + *    Executes libata internal command with timeout.  @tf contains
>>> + *    command on entry and result on return.  Timeout and error
>>> + *    conditions are reported via return value.  No recovery action
>>> + *    is taken after a command times out.  It's caller's duty to
>>> + *    clean up after timeout.
>>> + *
>>> + *    LOCKING:
>>> + *    None.  Should be called with kernel context, might sleep.
>>> + */
>>> +
>>> +static unsigned
>>> +ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
>>> +          struct ata_taskfile *tf,
>>> +          int dma_dir, void *buf, unsigned int buflen)
>>> +{
>>> +    u8 command = tf->command;
>>> +    struct ata_queued_cmd *qc;
>>> +    DECLARE_COMPLETION(wait);
>>> +    unsigned long flags;
>>> +    struct ata_exec_internal_arg arg;
>>> +
>>> +    if (ata_busy_sleep(ap, ATA_TMOUT_INTERNAL_QUICK, 
>>> ATA_TMOUT_INTERNAL))
>>> +        return AC_ERR_OTHER;
>>
>>
>>
>> NAK.  This sort of thing really belongs in the execution engine for 
>> each driver.  Advanced controllers have zero need for this.
>>
>> Moreover, why are you adding this, anyway?  This is a distinct 
>> regression from the nice "do everything inside ata_qc_issue" model 
>> that's been sprouting.
>>
> 
> I was thinking that as these internal commands are used for 
> initialization and possibly eh in the future, it would be better to give 
> drives longer time to get ready for commands.  So, the ata_busy_sleep 
> with ATA_TMOUT_INTERNAL_QUICK, ATA_TMOUT_INTERNAL timeouts.  Too 
> paranoid / unnecessary?

Yes, and it breaks the "use ata_queued_cmd for everything" model. 
Polling for BSY, etc. should happen in the time between the call to 
ata_qc_issue() and the call to ata_qc_complete().

There are some violations of this model in the SRST and IDENTIFY DEVICE 
code, but those need to be eliminated, not expanded :)


>>> +    spin_lock_irqsave(&ap->host_set->lock, flags);
>>> +
>>> +    qc = ata_qc_new_init(ap, dev);
>>> +    BUG_ON(qc == NULL);
>>> +
>>> +    qc->tf = *tf;
>>> +    qc->dma_dir = dma_dir;
>>> +    if (dma_dir != DMA_NONE) {
>>> +        ata_sg_init_one(qc, buf, buflen);
>>> +        qc->nsect = buflen / ATA_SECT_SIZE;
>>> +        printk("dma_dir=%d buflen=%u nsect=%d\n",
>>> +               dma_dir, buflen, qc->nsect);
>>> +    }
>>> +
>>> +    arg.waiting = &wait;
>>> +    arg.tf = tf;
>>> +    qc->complete_data = &arg;
>>> +    qc->complete_fn = ata_qc_complete_internal;
>>> +
>>> +    if (ata_qc_issue(qc))
>>> +        goto issue_fail;
>>> +
>>> +    spin_unlock_irqrestore(&ap->host_set->lock, flags);
>>> +
>>> +    if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
>>> +        int timedout;
>>> +
>>> +        spin_lock_irqsave(&ap->host_set->lock, flags);
>>> +
>>> +        /* We're racing with irq here.  If we lose, the
>>> +         * following test prevents us from completing the qc
>>> +         * again.  If completion irq occurs after here but
>>> +         * before the caller cleans up, it will result in a
>>> +         * spurious interrupt.  We can live with that.
>>> +         */
>>> +        timedout = arg.waiting != NULL;
>>> +        if (timedout)
>>> +            ata_qc_complete(qc, 0);
>>
>>
>>
>> This is not very wise, to pass 'nothing is wrong' to ata_qc_complete() 
>> upon timeout.
>>
> 
> The problem is that we may or may not complete the command successfully 
> due to the following slow completion handling.  So, completing with 
> AC_ERR_OTHER isn't very correct either.  This matters because the tf 
> registers are read from the completion callback and the completion 
> callback does so only on device errors.  The solutions are....
> 
> 1. leaving as it is with more comments
> 2. completing with AC_ERR_OTHER but always reading back tf regs in the 
> completion callback
> 
> I prefer #1, but I'm okay with #2, too.

If it times out, call it an error.  Easy enough.


> On a side note, I'm sort of doubtful about slow completion handling in 
> ata_exec_internal() and also in eng_timeout().  For example, if some 
> kind of electrical / cabling glitch occurs during command execution and 
> results in device internal reset, the device's reset status can easily 
> be interpreted as successful completion by slow completion handling.
> 
> Actually, in the current libata, this can be easily triggered by just 
> unplugging and replugging the cable on a busy drive as we don't handle 
> those events.

You're welcome to improve the libata error handling code ;-)

	Jeff


