From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/11] libata-eh-fw: implement new EH scheduling from
 PIO
Date: Thu, 18 May 2006 20:49:30 +0900
Message-ID: <446C5F4A.3030307@gmail.com>
References: <1147350444826-git-send-email-htejun@gmail.com> <446C4FA8.5020105@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.192]:24869 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750891AbWERLth (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 07:49:37 -0400
Received: by wx-out-0102.google.com with SMTP id s6so329292wxc
        for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 04:49:37 -0700 (PDT)
In-Reply-To: <446C4FA8.5020105@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Albert Lee wrote:
> Tejun Heo wrote:
>> PIO executes without holding host_set lock, so it cannot be
>> synchronized using the same mechanism as interrupt driven execution.
>> port_task framework makes sure that EH is not entered until PIO task
>> is flushed, so PIO task can be sure the qc in progress won't go away
>> underneath it.  One thing it cannot be sure of is whether the qc has
>> already been scheduled for EH by another exception condition while
>> host_set lock was released.
>>
>> This patch makes ata_poll_qc-complete() handle such conditions
>> properly and make it freeze the port if HSM violation is detected
>> during PIO execution.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  drivers/scsi/libata-core.c |   23 +++++++++++++++++++----
>>  1 files changed, 19 insertions(+), 4 deletions(-)
>>
>> 52240d1d208615e461c41a5c297f521a8a892f0d
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index 436ff5b..86d6a7d 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -3429,16 +3429,31 @@ skip_map:
>>   *	LOCKING:
>>   *	None.  (grabs host lock)
>>   */
>> -
>>  void ata_poll_qc_complete(struct ata_queued_cmd *qc)
>>  {
>>  	struct ata_port *ap = qc->ap;
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&ap->host_set->lock, flags);
>> -	ap->flags &= ~ATA_FLAG_NOINTR;
>> -	ata_irq_on(ap);
>> -	ata_qc_complete(qc);
>> +
>> +	if (ap->ops->error_handler) {
>> +		/* EH might have kicked in while host_set lock is released */
>> +		qc = ata_qc_from_tag(ap, qc->tag);
>> +		if (qc) {
>> +			if (!(qc->err_mask & AC_ERR_HSM)) {
>> +				ap->flags &= ~ATA_FLAG_NOINTR;
>> +				ata_irq_on(ap);
>> +				ata_qc_complete(qc);
>> +			} else
>> +				ata_port_freeze(ap);
> 
> I don't quite understand here. For the AC_ERR_HSM error, how does the
> EH get triggered after ata_port_freeze()? Do we wait until time out?
> 

/**
  *	ata_port_freeze - abort & freeze port
  *	@ap: ATA port to freeze
  *
  *	Abort and freeze @ap.
         ^^^^^^
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
  *	Number of aborted commands.
  */
int ata_port_freeze(struct ata_port *ap)
{
	int nr_aborted;

	WARN_ON(!ap->ops->error_handler);

	nr_aborted = ata_port_abort(ap);
                      ^^^^^^^^^^^^^^^^^^^
	__ata_port_freeze(ap);

	return nr_aborted;
}

-- 
tejun
