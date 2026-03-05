Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8976369238
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755177; cv=none; b=UX7KGq7stHutRG8KezuUqkuZMfxQz2D53Ng8igi2BaAabmlCuyEJ3N5IUxL6lO0XWdm2xe9JuyaO+kUq6TXovXmd4m8jnIwVRPMVWsPwZqnbZxEJkUPcDu6bJuzwuktNSHsovm6U5fY+S3xBoLqz4lqF3H/Pu2T74W9QB5LOKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755177; c=relaxed/simple;
	bh=1oNbuoQaT02dNljxXi7xFKqqsSExEnRlf/8Jma4mMP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yvle9xin/9nXtcq5Ev0cMFz67VSFllIFWYIQXP/Pxh5q6uN5xuxhGGvX/+nSa2xwyB6HPiA5PrQhY338Jrfkx0b7ybZwJf/JDTXYY3zxp5t7MmIdC7i62NFwA2mOdC2+6THd3keT3gtOSUQdiIbb0ut34eukr9ehRSfHXrHrP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I94E4RVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I94E4RVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE5C2BC87;
	Thu,  5 Mar 2026 23:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772755176;
	bh=1oNbuoQaT02dNljxXi7xFKqqsSExEnRlf/8Jma4mMP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I94E4RVdDAeLRdyxqBWOTb3XGd9X7pvjsehI1fCVThh0VL2puh0iUwc2g52UIAA2L
	 kjtGi59qltbxY90PEeSXKWQ3FQe1D5wfAIl65iydYRImXmyZtfMXPnvNESMjDndFi1
	 aQf8bEOUEwMjJUxDWWcqGEyUGaVPuSz1ZvlWuuuYXkkaYaU+fJAcArMwMLfnNGb3wR
	 o92rSmM+5OylWbTqpXKd2Eurz4hmtSF+pb+gR0gfLsWqPP7P+IY67pH8ssTtEXOqM/
	 PKbCdgyKFHWxcVRLXyKD2+JgOPsAKjIbgMvY43/yax6on0juNWRqp8/fcvAY2tGeqC
	 quo2k/TXI++BA==
Message-ID: <8011c682-7fc6-4cab-b142-d05fd3b09de0@kernel.org>
Date: Fri, 6 Mar 2026 08:59:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 02:59, Guenter Roeck wrote:
> Hi,
> 
> On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
>> A deferred qc may timeout while waiting for the device queue to drain
>> to be submitted. In such case, since the qc is not active,
>> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
>> which frees the qc. But as the port deferred_qc field still references
>> this finished/freed qc, the deferred qc work may eventually attempt to
>> call ata_qc_issue() against this invalid qc, leading to errors such as
>> reported by UBSAN (syzbot run):
>>
>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
>> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
>> ...
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:94 [inline]
>>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
>>  ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
>>  ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
>>  process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
>>  process_scheduled_works kernel/workqueue.c:3358 [inline]
>>  worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
>>  kthread+0x370/0x450 kernel/kthread.c:467
>>  ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>  </TASK>
>>
>> Fix this by checking if the qc of a timed out SCSI command is a deferred
>> one, and in such case, clear the port deferred_qc field and finish the
>> SCSI command with DID_TIME_OUT.
>>
>> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
>> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
>> ---
>>  drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 72a22b6c9682..b373cceb95d2 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>  		set_host_byte(scmd, DID_OK);
>>  
>>  		ata_qc_for_each_raw(ap, qc, i) {
>> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> -			    qc->scsicmd == scmd)
>> +			if (qc->scsicmd != scmd)
>> +				continue;
>> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
>> +			    qc == ap->deferred_qc)
>>  				break;
>>  		}
>>  
>> -		if (i < ATA_MAX_QUEUE) {
>> +		if (qc == ap->deferred_qc) {
> 
> An experimental AI code review agent tagged this patch with the following
> comment.

Thanks for that.

>   If the `ata_qc_for_each_raw()` loop finishes without finding a matching `scmd`,
>   `qc` will hold a pointer to the last element examined (`i == ATA_MAX_QUEUE`).
>   If this last element happens to be `ap->deferred_qc`, the condition
>   `qc == ap->deferred_qc` evaluates to true despite the loop not breaking on a
>   match.
> 
>   Could this mistakenly intercept a command that completed normally after a SCSI
>   timeout, returning a timeout error instead of success? Would this also
>   incorrectly clear `ap->deferred_qc`, dropping the deferred command?
>   Should we verify that the loop actually found a match, for instance by checking
>   `if (i < ATA_MAX_QUEUE && qc == ap->deferred_qc)`?

Yeah. Something like this. But that condition cannot actually happen. i ==
ATA_MAX_QUEUE correspond to internal QCs, and these never go through the
deferred path.

> It does seem to be a real problem to me, but I don't know the code well
> enough to be sure. Please take a look and let me know if the problem is
> real. If so, I'll be happy to submit a patch to fix it. If not, please let
> me know what the agent is missing.

See above. That is not a real problem, but it would still be good to check. I
think your change is fine. Car to send a proper patch ?

-- 
Damien Le Moal
Western Digital Research
