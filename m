From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ATAPI error handling work
Date: Thu, 06 Oct 2005 23:56:43 +0900
Message-ID: <43453B2B.30405@gmail.com>
References: <43443CC7.5040706@pobox.com> <20051006053529.GA25976@htj.dyndns.org> <4344F7C0.4030803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:12773 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751016AbVJFO4v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 10:56:51 -0400
Received: by wproxy.gmail.com with SMTP id i4so210578wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2005 07:56:50 -0700 (PDT)
In-Reply-To: <4344F7C0.4030803@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Douglas Gilbert <dougg@torque.net>


  Hello, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
[-snip-]
>>
>>  I'm not really sure if synchronization around reqsense with
>> ATA_FLAG_IN_EH is such a good idea for the following reasons.
>>
>> * IMHO, tugging in request sense into the timeout window of the
>>   original command is okay (or even better).
> 
> 
> Not really:  we have to assume that time passed, so by relying on the 
> SCSI EH timeout rather than a timer, the timeout is suddenly effectively 
> random.  I want a definitive time length, since its likely REQUEST SENSE 
> may need a longer timeout for some devices.
> 
> Second, the timeout for READ/WRITE commands is often smaller than it is 
> for non-READ/WRITE commands.  We want much to ensure that we have 
> sufficient time to handle REQUEST SENSE.
> 

  Ah.. I see.  I was assuming

- If a device fails a command (not timing out), it probably does it in
   reasonable amount of time.

- REQUEST_SENSE wouldn't take very long.

  I guess my assumptions were too hopeful.  :-(

> 
>> * As long as we grab host_set lock while submitting request sense,
>>   which we already does, the synchronization can be done safely in EH
>>   proper.  libata EH isn't currently ready for this but other commands
>>   are dealt the same way and fixing EH is the correct way, IMHO.
> 
> 
> We grab the lock submitting request sense, but then we release it. 
> ata_eng_timeout() could get called before the entire REQUEST SENSE 
> process is completed.
> 
 >
 >>  Note that we really don't have to do anything special for timing out
 >> during request sense.  Once we fix EH/interrupt handler race, it can
 >> be handled the same way without any speical casing.
 >
 >
 > Yes, this is feasible.  We can simply wait for the timer (which doesn't
 > exist yet) or atapi_qc_complete_sense() to clear the ATA_FLAG_IN_EH bit,
 > at which point the EH timer takes over, or will do so shortly.
 >

  As I wrote in the libata EH doc and associated thread, I don't think 
doing autosensing-by-turning-qc-around is a very good idea.  I hope I 
can make some point here.

  In the other thread, you wrote that the current ATAPI sense 
requisition is corrupt because it finishes scmd twice and I believe this 
patch was implemented to fix that.  I disagreed with you in that thread 
and gave my rationale for that.  If I was wrong in that thread, please 
ignore what follows.

  Reasons why I think doing auto-sensing isn't such a good idea.

* I think that not having qc-turn-around is cleaner and easier to
   maintain.

* We need EH anyway and sense requesting can be easily done with EH
   mechanisms.  Command handoff to EH is definitely necessary for all EH
   cases, so ATAPI command handoff can be done just the same.  EH
   needs to issue commands and also need timeouts.  We can use the same
   mechanism for REQUEST SENSE.  No special timer or flag is needed.  I
   even have submitted a patch to add timeouts to all EH commands.  IIRC,
   I've also converted REQUEST_SENSE to have time out.

* Autosensing does have performance advantage.  But it's not a hot path.
   I doubt the performance advantage is anything worth of the added
   complexity.

> 
>>>     qc = ata_qc_from_tag(ap, ap->active_tag);
>>> -    if (!qc) {
>>> +    if (qc)
>>> +        ata_qc_timeout(qc);
>>> +    else {
>>>         printk(KERN_ERR "ata%u: BUG: timeout without command\n",
>>>                ap->id);
>>>         goto out;
>>>     }
>>>
>>> -    ata_qc_timeout(qc);
>>>
>>> out:
>>>     DPRINTK("EXIT\n");
>>
>>
>>
>>
>>  I think you were trying to kill goto out and the label by moving
>> ata_qc_timeout() into if condition, no?  Currently, the goto out seem
>> a bit funny.
> 
> 
> The goto is gone in the most recent version :)
> 
> 
>>> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
>>> --- a/drivers/scsi/libata-scsi.c
>>> +++ b/drivers/scsi/libata-scsi.c
>>> @@ -225,7 +225,7 @@ void ata_to_sense_error(struct ata_queue
>>>     };
>>>     int i = 0;
>>>
>>> -    cmd->result = SAM_STAT_CHECK_CONDITION;
>>> +    cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>>>
>>>     /*
>>>      *    Is this an error we can process/parse
>>> @@ -1468,7 +1468,7 @@ unsigned int ata_scsiop_report_luns(stru
>>> void ata_scsi_badcmd(struct scsi_cmnd *cmd, void (*done)(struct 
>>> scsi_cmnd *), u8 asc, u8 ascq)
>>> {
>>>     DPRINTK("ENTER\n");
>>> -    cmd->result = SAM_STAT_CHECK_CONDITION;
>>> +    cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>>>
>>>     cmd->sense_buffer[0] = 0x70;
>>>     cmd->sense_buffer[2] = ILLEGAL_REQUEST;
>>> @@ -1479,28 +1479,81 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
>>>     done(cmd);
>>> }
>>>
>>> +static int atapi_qc_complete_sense(struct ata_queued_cmd *qc, u8 
>>> drv_stat)
>>> +{
>>> +    struct scsi_cmnd *cmd = qc->scsicmd;
>>> +
>>> +    if (ata_ok(drv_stat))
>>> +        cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>>> +    else
>>> +        ata_to_sense_error(qc, drv_stat);
>>> +
>>> +    qc->ap->flags &= ~ATA_FLAG_IN_EH;
>>> +    qc->scsidone(cmd);
>>> +    return 0;
>>> +}
>>> +
>>> +static void atapi_request_sense(struct ata_queued_cmd *qc)
>>> +{
>>> +    struct ata_port *ap = qc->ap;
>>> +    struct scsi_cmnd *cmd = qc->scsicmd;
>>> +    int rc;
>>> +
>>> +    DPRINTK("ATAPI request sense\n");
>>> +
>>> +    /* FIXME: is this needed? */
>>> +    memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
>>
>>
>>
>>
>>  This is just a side note as this part seems to be just copied from
>> the original request_sense function.  Anyways, I think this isn't
>> needed anymore.  SCSI ML seems to clear things pretty thoroughly these
>> days.
> 
> 
> Well, until I have the line of code pointed to me, its not important. 
> Its not the hot path, so we can afford to do possibly-redundant work.
> 

  It's in scsi_get_command and scsi_setup_cmd_retry.  But I agree with 
you that leaving it alone would be a better idea.  Maybe chaning comment 
will help clear things a bit?  something like /* paranoia */?

> 
>>> +    ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
>>> +    qc->dma_dir = DMA_FROM_DEVICE;
>>> +
>>> +    memset(&qc->cdb, 0, ap->cdb_len);
>>> +    qc->cdb[0] = REQUEST_SENSE;
>>> +    qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
>>> +
>>> +    qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>>> +    qc->tf.command = ATA_CMD_PACKET;
>>> +
>>> +    qc->tf.protocol = ATA_PROT_ATAPI;
>>> +    qc->tf.lbam = (8 * 1024) & 0xff;
>>> +    qc->tf.lbah = (8 * 1024) >> 8;
>>> +    qc->nbytes = SCSI_SENSE_BUFFERSIZE;
>>> +
>>> +    qc->complete_fn = atapi_qc_complete_sense;
>>> +
>>> +    rc = ata_qc_issue(qc);
>>> +
>>> +    if (rc) {
>>> +        /* FIXME: complete failing command with an error */
>>> +        ata_port_disable(ap);
>>> +    }
>>> +
>>> +    /* FIXME: add timer for timeout of this command */
>>> +    /* control flow continues in atapi_qc_complete_sense() */
>>> +
>>> +    DPRINTK("EXIT\n");
>>> +}
>>> +
>>> static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
>>> {
>>> +    struct ata_port *ap = qc->ap;
>>>     struct scsi_cmnd *cmd = qc->scsicmd;
>>>
>>> +    rmb();
>>
>>
>>
>>
>>  I'm having difficult time understanding this rmb().  What is it
>> protecting against?
> 
> 
> Just paranoia, before reading ap->host->eh_active, which is tweaked by 
> scsi_error.c.

  Maybe it's just me, but codes with [r|w]mb's without clear context or 
comment are among the most difficult codes to understand.  And I 
personally think that mb's should be used only when strictly necessary 
because otherwise they are exteremely confusing later.

  Maybe putting some comments there can help other guys like me spend 
less time wondering about it?

  Thanks. :-)

-- 
tejun
