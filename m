Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B829BD95
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756489; cv=none; b=qHyarMsyXMZs/4gh7tPFo2EffamQC2uBK7RPnioG3uY6mwKbIlasQDzynGhEf32gagyAM1S3NLU8Y3ka3z6QZ+p5yn1HYNdYTF4DyMnRHc+B5wwf6botOj4+4x9JXhkIvRGO3U6FTEvjTCqPFpOXwt8aamOrEkUrjrd7YfcbqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756489; c=relaxed/simple;
	bh=7hVlFIc843YZOLBmQHrfgIC7xp8+dD7CYkcm/byeFuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDAcZEEfew3VGEBI49JqBHITT7vv4d/kjwYhq+GjyJYOvvUBO+3kjtCqQ2oTEAhrincZXBWBysDPyhS91H9Q/bvFMTqrfUn0ePfTkhtYRxajT6IVeWj9JK/0oJx+n04yKnV2tA7Ns8ynWa2U1IIG/0CsFjF5xxspLWwelEBE6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtA67Kip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtA67Kip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D79DC116C6;
	Fri,  6 Mar 2026 00:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772756488;
	bh=7hVlFIc843YZOLBmQHrfgIC7xp8+dD7CYkcm/byeFuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtA67KiprQOybdsG4kaF0pIISOIU+1NJWyjC5sSs6KD59ixAlIZcZjIsEfcWOcHrz
	 FOcjU4SsJFQodXtn127PrdYI4xX++IfGDv1WuVqWmhOarzOQhH+kFVzEwbOqBqeYkT
	 BbI7Gf3KPq3opN15OPHsi7ZpnYIGfnvZ5AlXvgcaqP1nOZqJF/WDrrZ4jq17nsDejT
	 HFEdMFWUdBSFs2s6NBwZBSZDu8yaEaA+w5RNOc6ehgd+APbdpCaXITUvbY8FZkpEBi
	 iQV5crpWvj7kOAVCnqozOmd8q79ZJDI/O81mliNDn0h85yLmu/Ck/TVo52TRPcmMkI
	 s9t7UMqrjPMeg==
Message-ID: <cbc113d1-55a1-41f5-8481-25c707f2ef86@kernel.org>
Date: Fri, 6 Mar 2026 09:21:26 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
To: Guenter Roeck <linux@roeck-us.net>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
 <81f2f823-8e66-48d8-bf1c-07b0aa7d49c7@roeck-us.net>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <81f2f823-8e66-48d8-bf1c-07b0aa7d49c7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 09:14, Guenter Roeck wrote:
> On Fri, Mar 06, 2026 at 12:27:34AM +0100, Niklas Cassel wrote:
>> On 5 March 2026 18:59:08 CET, Guenter Roeck <linux@roeck-us.net> wrote:
>>> Hi,
>>>
>>> On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
>>>> A deferred qc may timeout while waiting for the device queue to drain
>>>> to be submitted. In such case, since the qc is not active,
>>>> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
>>>> which frees the qc. But as the port deferred_qc field still references
>>>> this finished/freed qc, the deferred qc work may eventually attempt to
>>>> call ata_qc_issue() against this invalid qc, leading to errors such as
>>>> reported by UBSAN (syzbot run):
>>>>
>>>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
>>>> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
>>>> ...
>>>> Call Trace:
>>>>  <TASK>
>>>>  __dump_stack lib/dump_stack.c:94 [inline]
>>>>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>>>>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>>>>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
>>>>  ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
>>>>  ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
>>>>  process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
>>>>  process_scheduled_works kernel/workqueue.c:3358 [inline]
>>>>  worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
>>>>  kthread+0x370/0x450 kernel/kthread.c:467
>>>>  ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>>>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>>  </TASK>
>>>>
>>>> Fix this by checking if the qc of a timed out SCSI command is a deferred
>>>> one, and in such case, clear the port deferred_qc field and finish the
>>>> SCSI command with DID_TIME_OUT.
>>>>
>>>> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
>>>> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
>>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
>>>> ---
>>>>  drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
>>>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>>> index 72a22b6c9682..b373cceb95d2 100644
>>>> --- a/drivers/ata/libata-eh.c
>>>> +++ b/drivers/ata/libata-eh.c
>>>> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>>>  		set_host_byte(scmd, DID_OK);
>>>>  
>>>>  		ata_qc_for_each_raw(ap, qc, i) {
>>>> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>>>> -			    qc->scsicmd == scmd)
>>>> +			if (qc->scsicmd != scmd)
>>>> +				continue;
>>>> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
>>>> +			    qc == ap->deferred_qc)
>>>>  				break;
>>>>  		}
>>>>  
>>>> -		if (i < ATA_MAX_QUEUE) {
>>>> +		if (qc == ap->deferred_qc) {
>>>
>>> An experimental AI code review agent tagged this patch with the following
>>> comment.
>>>
>>>  If the `ata_qc_for_each_raw()` loop finishes without finding a matching `scmd`,
>>>  `qc` will hold a pointer to the last element examined (`i == ATA_MAX_QUEUE`).
>>
>> I think the AI is wrong here.
>>
>> That last element assigned to QC will be ATA_MAX_QUEUE - 1.
>>
> 
> I think that is what it means with "`qc` will hold a pointer to the
> last element examined". The "(`i == ATA_MAX_QUEUE`) part is a bit
> confusing.
> 
> I think what it is trying to say is that if i == ATA_MAX_QUEUE,
> qc would point to the last examined element, which would not
> have ATA_QCFLAG_ACTIVE set because otherwise it would have
> exited the loop. Yet, ap->deferred_qc could be set, and the
> if statement would be true even though i == ATA_MAX_QUEUE
> and there was no qc match.
> 
>>
>>>  If this last element happens to be `ap->deferred_qc`, the condition
>>>  `qc == ap->deferred_qc` evaluates to true despite the loop not breaking on a
>>>  match.
>>>
> 
> That is pretty much much repeating what I said above, without
> the confusing "(`i == ATA_MAX_QUEUE`)" part.
> 
>>>  Could this mistakenly intercept a command that completed normally after a SCSI
>>>  timeout, returning a timeout error instead of success? Would this also
>>>  incorrectly clear `ap->deferred_qc`, dropping the deferred command?
>>
> 
> This part is beyond my understanding, primarily because I don't know
> what "qc->deferred" actually refers to.

There are 2 types of ATA commands: queueable ones (NCQ == Native Command
Queueing) and non-queueable ones (legacy/old ATA commands). The 2 types cannot
be mixed. When NCQ commands are on-going, you cannot issue a non-NCQ command,
and vice-versa. This has always been handled with command requeueing in
libata-scsi (since forever), but with blk-mq introduction, there was a potential
command starvation issue for non-NCQ commands that has existed for a long time.

We fixed that recently by keeping on hand any non-NCQ command that must wait for
on-going NCQ commands to complete first. This is ap->deferred_qc.

> 
>> I think the AI is partially wrong here.
>>
>> If you read the comment below it if (), we know that ap->deferred_qc is only set until that command has been issued. So if it is set, that qc has not been issued, so it can't have successfully completed.
>>
>> But... Since we don't verify that i < ATA_MAX_QUEUE, we might end up completing the deferred QC as a failed command, even though it did not time out...
>>
>> On NCQ error, we complete the deferred QC as a failed command.
>>
>> However, if there was a timeout of a command, which was not the deferred QC, but the deferred QC did not timeout, I think it is wrong to complete the deferred QC as a failed command.
>>
>> So... I actually think that the change suggested by the AI is something we want.
>> (Especially after Damien commit queued in for-next where we will not invoke error_handler() if there were no timed out commands.)
>>
> 
> So should I send a patch, or do you want to handle it ?
> It might be better if you handle it since I don't know
> how to exactly describe the problem differently than the AI.

Send a patch. Write a commit message based on the information I sent in my
previous email. We can correct the commit message if needed.

> 
> Thanks,
> Guenter


-- 
Damien Le Moal
Western Digital Research
