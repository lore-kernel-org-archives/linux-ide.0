Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC231F98D
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568231; cv=none; b=CJ2qFwUmnXIbJBfxOVF9sHIlqhO6SWjjLrhosNbOoF0mjf/S5MYt/RjxbKHDy5DX/LMsd8DmM40d/a8E/wPEeKzFj+il7PRdvMYJDfI6A2BGbpVieygGEx/FtcKc9JllCSDfaWcCae6G5bZP0LGW641bX1sLBeIKk9E9GsOHpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568231; c=relaxed/simple;
	bh=tkTvOujs0ykF0cquqV0RNPcH/T9kRxEdmXY55wfcmGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=istxxfuSgYh7+AF6nmP+IsSvAqsNbKc/59IKLO2wEEV7xR6/QqTYv+ipTHjdA3RJTrrdH0rlNioAl8Kg5AdAvnZwyAQ+b1lXDUDLinZjM6YlnhaSOf00HnY3SXTJ5x+5MWTECsVYnOtuNgdBhHh18/k2Yx2nV2JB3C0Fij8EOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMj4AuEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMj4AuEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2B71F000E9;
	Thu,  9 Jul 2026 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783568229;
	bh=qtiIrsSg4oOUdasQ6SPQXdCfPeyOQay6Kg08rw6Dul4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MMj4AuEOC2YIuQcTwO1mdYQVXxwlV7q1me5xe82wmmck2f+Kgn1nbhE+g2nGxFEVr
	 2qLTL+Z1rA17Hv/q6UPC+9KlK9hVMp4ApKr4art5aDWODIE1v5ta+GStPsOa6g1bHY
	 WfLOFQN+c90OfDzv2Q9kFaX0XKIqfb/z8cwRzwbVYE1crNqC4fgvMNBgQK+6oAwR9Z
	 krqiZqSpZ+svt6/QwnncT+m2Y1BECJH2HyagachjxmhHdfZ6+S/zFBL8lrx25XLIVV
	 scGVsnowhMsXfDhdzCquAxjR2/6LjnmD1pX5z9C4G5NUgfCjmCr7OZ4xFoOfd7+36G
	 oectiyc3S/KVg==
Message-ID: <2c0de926-25fa-4bd3-9a79-44fce94e6c2d@kernel.org>
Date: Thu, 9 Jul 2026 12:37:07 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI EH wakeup deadlock from deferred_qc
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
References: <20260708193644.671852-1-ipylypiv@google.com>
 <4a1b8987-7c76-41e2-baf9-6c176950593b@kernel.org>
 <26dbfbdd-4f9d-4a5f-8f61-a3bb7c457f50@kernel.org>
 <ak8GcZ2k0AIkpMCe@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ak8GcZ2k0AIkpMCe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 11:24, Igor Pylypiv wrote:
> On Thu, Jul 09, 2026 at 10:01:11AM +0900, Damien Le Moal wrote:
>> On 7/9/26 08:44, Damien Le Moal wrote:
>>> On 7/9/26 04:36, Igor Pylypiv wrote:
>>>> Hi Damien,
>>>>
>>>> I've stumbled upon an issue where SCSI EH didn't run upon command timeout
>>>> but ran ~10 or so seconds later. It seems like a recent regression from
>>>> the introduction of deffered_qc.
>>>>
>>>> When an active command times out while a non-NCQ command is waiting in
>>>> deferred_qc, SCSI EH fails to wake up. Recovery stalls until the deferred
>>>> command's own timer expires.
>>>>
>>>> When an NCQ command times out, scsi_timeout() calls scsi_eh_scmd_add(),
>>>> incrementing shost->host_failed (1). However, when scsi_eh_wakeup() checks
>>>> whether to wake the EH thread, scsi_host_busy(shost) counts 2 active
>>>> commands (1 timed-out + 1 in deferred_qc).
>>>>
>>>> Because busy (2) != host_failed (1), scsi_eh_wakeup() refuses to wake
>>>> the EH thread, deadlocking error recovery until the deferred command
>>>> times out on its own.
>>>
>>> Igor,
>>>
>>> Can you try the attached diff ?
>>> I will test on my end, but I need to hack something to trigger a timeout :)
>>
>> Hacking libahci to trigger a timeout for a particular LBA read, I tested the
>> attached v2 and I see the deferred QC running right after the read command
>> timeout. So this looks like a good fix to me. Can you test please ?
> 
> Thank you for coming up with a fix so quickly, Damien!
> The fix works for the issue I'm seeing!
> 
> Note: I tested on a 6.18 based kernel with your changes ported to libsas
> to fix the issue for the pm80xx driver. Attached libsas diff for reference.

Thanks for the diff. I will add it to the patch, and if that's OK with you, also
add a co-developed-by tag ?

> 
> Thank you!
> Igor
> 
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 5868526301a2..5221d7004c0e 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -1685,7 +1685,8 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
>>  	spin_unlock_irqrestore(ap->lock, flags);
>>  }
>>  
>> -void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>> +static void ata_scsi_do_requeue_deferred_qc(struct ata_port *ap,
>> +					    struct scsi_cmnd *timed_out_scmd)
>>  {
>>  	struct ata_link *link;
>>  
>> @@ -1698,15 +1699,27 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>>  	 */
>>  	ata_for_each_link(link, ap, PMP_FIRST) {
>>  		struct ata_queued_cmd *qc = link->deferred_qc;
>> +		u32 host_byte;
>>  
>> -		if (qc) {
>> -			link->deferred_qc = NULL;
>> -			cancel_work(&link->deferred_qc_work);
>> -			ata_scsi_qc_done(qc, true, DID_REQUEUE << 16);
>> -		}
>> +		if (!qc)
>> +			continue;
>> +
>> +		link->deferred_qc = NULL;
>> +		cancel_work(&link->deferred_qc_work);
>> +
>> +		if (qc->scsicmd == timed_out_scmd)
>> +			host_byte = DID_TIME_OUT;
>> +		else
>> +			host_byte = DID_REQUEUE;
>> +		ata_scsi_qc_done(qc, true, host_byte << 16);
>>  	}
>>  }
>>  
>> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>> +{
>> +	ata_scsi_do_requeue_deferred_qc(ap, NULL);
>> +}
>> +
>>  static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
>>  {
>>  	struct ata_queued_cmd *qc = link->deferred_qc;
>> @@ -1730,6 +1743,28 @@ static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
>>  		queue_work(system_highpri_wq, &link->deferred_qc_work);
>>  }
>>  
>> +enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *scmd)
>> +{
>> +	struct ata_port *ap = ata_shost_to_port(scmd->device->host);
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * We had a timeout, either for an NCQ command or for one deferred
>> +	 * queued command. Either way, we must release all deferred queued
>> +	 * command so that scsi EH can trigger.
>> +	 */
>> +	spin_lock_irqsave(ap->lock, flags);
>> +	ata_scsi_do_requeue_deferred_qc(ap, scmd);
>> +	spin_unlock_irqrestore(ap->lock, flags);
>> +
>> +	/*
>> +	 * Let scsi_timeout() know that it must continue with handling the
>> +	 * timeout as we in fact did not do much here.
>> +	 */
>> +	return SCSI_EH_NOT_HANDLED;
>> +}
>> +EXPORT_SYMBOL_GPL(ata_scsi_eh_timed_out);
>> +
>>  static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>>  {
>>  	struct ata_link *link = qc->dev->link;
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 96e626d6a7ca..327da43d7496 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -1153,6 +1153,7 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
>>  #endif
>>  extern enum scsi_qc_status ata_scsi_queuecmd(struct Scsi_Host *h,
>>  					     struct scsi_cmnd *cmd);
>> +enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *cmd);
>>  #if IS_REACHABLE(CONFIG_ATA)
>>  bool ata_scsi_dma_need_drain(struct request *rq);
>>  #else
>> @@ -1464,6 +1465,7 @@ extern const struct attribute_group *ata_common_sdev_groups[];
>>  	.ioctl			= ata_scsi_ioctl,		\
>>  	ATA_SCSI_COMPAT_IOCTL					\
>>  	.queuecommand		= ata_scsi_queuecmd,		\
>> +	.eh_timed_out		= ata_scsi_eh_timed_out,	\
>>  	.dma_need_drain		= ata_scsi_dma_need_drain,	\
>>  	.this_id		= ATA_SHT_THIS_ID,		\
>>  	.emulated		= ATA_SHT_EMULATED,		\
> 


-- 
Damien Le Moal
Western Digital Research
