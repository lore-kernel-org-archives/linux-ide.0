Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECB22D7B9
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755910; cv=none; b=hGK3ygD3IZkICyJzr71NSYdWejCeLz3Oqk1/H9rHeVy7f/7CQ2I8YgSq72IN7hfAHtG53BVRASKZguncESXk3TK1xmhnzPuqN5qMH9NyvzmYv+dEAg0mxp5+nHmPwvxPq8iF/9mQ+ysfY9Vk9Rny7nxObE0z6+mveRgnX/tXPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755910; c=relaxed/simple;
	bh=raSjcNQ7u9fshczqHyMwRh38q3VsDpj17TcyZi/RHvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/KD3ng2NEecUqvFuE6cnC3v7ya/0gtmV9eFw5DvhODkKlSkFR27k3qBTCxStgdTnPbaJQg8a4iZHFcx+yHjJ0R99aEi6Xs7zNxGDHmfCrJt5TwIj91Ev7YSAxsDg/6ZDIlEY1C14ZRNfKZUpX42AJcEdAZwS6NV0ZwL/vKzO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hacOTue6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hacOTue6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD51DC116C6;
	Fri,  6 Mar 2026 00:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772755910;
	bh=raSjcNQ7u9fshczqHyMwRh38q3VsDpj17TcyZi/RHvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hacOTue6FZ8m06+VBWhadsGq10rukhIDRBBXYx1MwguvflO1SNUwwr0DlJNAiaLzX
	 VtfmYzeE6cpUXEmIffankzCdzH/cx9GI5KbGKaPtJt7SRDKwTjShlKUizUfW55cIgo
	 O9mRKbTeo11FaTtH1dleXhU8AdFqmdSv4M7/pyxm9LWw0axWjMqAOGk5JKogcRApSJ
	 zKw2qmfds4AF71sSrCU6ZQJes0FNwFO0LdvwMsqbbTcTlTxtKRvAF3qvm8ZjbeRsBg
	 rrTE5xrhr5nf7LUAZB1meBMI8adyYEIPCsTHk0SYN6uIusN2AIgrk1X00paUrq2ale
	 uxeX0rNTQh7AQ==
Message-ID: <dd7763d3-1822-404e-b763-ae25f68b21ae@kernel.org>
Date: Fri, 6 Mar 2026 09:11:48 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
To: Niklas Cassel <cassel@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-ide@vger.kernel.org
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 08:27, Niklas Cassel wrote:
> On 5 March 2026 18:59:08 CET, Guenter Roeck <linux@roeck-us.net> wrote:
>> Hi,
>> 
>> On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
>>> A deferred qc may timeout while waiting for the device queue to drain to
>>> be submitted. In such case, since the qc is not active, 
>>> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(), which
>>> frees the qc. But as the port deferred_qc field still references this
>>> finished/freed qc, the deferred qc work may eventually attempt to call
>>> ata_qc_issue() against this invalid qc, leading to errors such as 
>>> reported by UBSAN (syzbot run):
>>> 
>>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24 shift
>>> exponent 4210818301 is too large for 64-bit type 'long long unsigned
>>> int' ... Call Trace: <TASK> __dump_stack lib/dump_stack.c:94 [inline] 
>>> dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120 ubsan_epilogue+0xa/0x30
>>> lib/ubsan.c:233 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/
>>> ubsan.c:494 ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166 
>>> ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679 
>>> process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275 
>>> process_scheduled_works kernel/workqueue.c:3358 [inline] 
>>> worker_thread+0x5da/0xe40 kernel/workqueue.c:3439 kthread+0x370/0x450
>>> kernel/kthread.c:467 ret_from_fork+0x754/0xd80 arch/x86/kernel/
>>> process.c:158 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245 
>>> </TASK>
>>> 
>>> Fix this by checking if the qc of a timed out SCSI command is a deferred 
>>> one, and in such case, clear the port deferred_qc field and finish the 
>>> SCSI command with DID_TIME_OUT.
>>> 
>>> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com 
>>> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command
>>> starvation") Signed-off-by: Damien Le Moal <dlemoal@kernel.org> Reviewed-
>>> by: Hannes Reinecke <hare@suse.de> Reviewed-by: Igor Pylypiv
>>> <ipylypiv@google.com> --- drivers/ata/libata-eh.c | 22 ++++++++++++++++++
>>> +--- 1 file changed, 19 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c index
>>> 72a22b6c9682..b373cceb95d2 100644 --- a/drivers/ata/libata-eh.c +++ b/
>>> drivers/ata/libata-eh.c @@ -640,12 +640,28 @@ void
>>> ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, 
>>> set_host_byte(scmd, DID_OK);
>>> 
>>> ata_qc_for_each_raw(ap, qc, i) { -			if (qc->flags & ATA_QCFLAG_ACTIVE
>>> && -			    qc->scsicmd == scmd) +			if (qc->scsicmd != scmd) +
>>> continue; +			if ((qc->flags & ATA_QCFLAG_ACTIVE) || +			    qc == ap-
>>> >deferred_qc) break; }
>>> 
>>> -		if (i < ATA_MAX_QUEUE) { +		if (qc == ap->deferred_qc) {
>> 
>> An experimental AI code review agent tagged this patch with the following 
>> comment.
>> 
>> If the `ata_qc_for_each_raw()` loop finishes without finding a matching
>> `scmd`, `qc` will hold a pointer to the last element examined (`i ==
>> ATA_MAX_QUEUE`).
> 
> I think the AI is wrong here.
> 
> That last element assigned to QC will be ATA_MAX_QUEUE - 1.
> 
> 
>> If this last element happens to be `ap->deferred_qc`, the condition `qc ==
>> ap->deferred_qc` evaluates to true despite the loop not breaking on a 
>> match.
>> 
>> Could this mistakenly intercept a command that completed normally after a
>> SCSI timeout, returning a timeout error instead of success? Would this
>> also incorrectly clear `ap->deferred_qc`, dropping the deferred command?
> 
> I think the AI is partially wrong here.
> 
> If you read the comment below it if (), we know that ap->deferred_qc is only
> set until that command has been issued. So if it is set, that qc has not
> been issued, so it can't have successfully completed.

The request for the qc/scsi command was started from the block layer perspective
and so can still timeout. So this is all valid.

BUT ATA_MAX_QUEUE qc (last in the loop if there is no match) is the one reserved
for internal commands issued from EH. Internal QCs do not go through the
deferred issue path, so even without checking for the index when there is no
match, we have:
 - qc is still a valid pointer (the array of QCs is ATA_MAX_QUEUE + 1 sized)
 - We can never have qc == ap->deferred_qc.

As-is, the code is fine, but the above is not super clear :)

> But... Since we don't verify that i < ATA_MAX_QUEUE, we might end up
> completing the deferred QC as a failed command, even though it did not time
> out...

Nope. If there is no match, it means that we do not have a QC anymore and so
completing the command is OK (this is the race case with the ATA driver
signaling a completion with an IRQ).

> On NCQ error, we complete the deferred QC as a failed command.

No we do not, we requeue the deferred QC in EH. That qc has not been issued, so
the NCQ error did not affect it.

> However, if there was a timeout of a command, which was not the deferred QC,
> but the deferred QC did not timeout, I think it is wrong to complete the
> deferred QC as a failed command.

We do not complete it, we requeue it from EH.

> So... I actually think that the change suggested by the AI is something we
> want. (Especially after Damien commit queued in for-next where we will not
> invoke error_handler() if there were no timed out commands.)

Yes, I think the proposed fix is fine. When the deferred qc is not a match, that
restores the same behavior of this function as before we added the deferred qc
stuff.



-- 
Damien Le Moal
Western Digital Research
