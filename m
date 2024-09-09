Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DB1BAECA
	for <linux-ide@vger.kernel.org>; Mon,  9 Sep 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889529; cv=none; b=aYxclSpT9Oz3PfEPW5h9r+Y6rapaWYKILmvuJSw2NYTYaau/yEfl8dx8+pJRq1ueOmnXkXCaQodtafBSpAbJtyEP2zzSfSMFcibomVOw6UAw6gdofhEsFN/NsHvfpHE3I+AhKV2wo+OLVGu/5OkCAtf3zugloXQr0CaUG1FqdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889529; c=relaxed/simple;
	bh=uHj2Klw5OUcHsbuvtHOazKLGzfchJs2qAso0237UxU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZi76HlWrLbSVVTXBuJi+FWfDXkDmelNhv+g31BnPFJ/RUv3U+xdaEgXsivvtKPefGkVJpLBHa7/prWADQ6Nilw4skvRwe8esE/gBdzhbogec3uoTVsijj3UZLaboQ2HvEYsVy+dK3Xy7pgRpnmqGIK68B9VmiG6VTv0DScU2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svQo0xT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svQo0xT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84844C4CEC8;
	Mon,  9 Sep 2024 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725889529;
	bh=uHj2Klw5OUcHsbuvtHOazKLGzfchJs2qAso0237UxU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=svQo0xT7OA+xMeBfqadh3Dq4XIdLSZm9RvBOLfLnAGigf/9kkseW/+JQxDRNttTiz
	 g5hg07ILVmNq07ExH2UVrLrFez3DBfQMOOkWDwznyBOxW26f2C3efew9QU8atOWtNq
	 9B02iEGd+64aNRP7OILWpfH+T56/Es/lAKZ0glwSyrQiTmIBTnSmRVjZKJIx1jAeav
	 R28G4yILEx+JQGteAyikIrIJSQlT2NW/OweBSO5r6iy4xR71i1RRbMDvzcSKJwUSO3
	 lSSvrAudVaRZMjlvqUCAvjNeooIIzh1nCSzDdartWqwYei9h4YPRRK29/m0P6lQifx
	 IHOUQHuYRWuqg==
Message-ID: <49efce27-3d59-4fd2-9c58-c40c3f7c0d15@kernel.org>
Date: Mon, 9 Sep 2024 22:45:27 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
To: Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Igor Pylypiv <ipylypiv@google.com>,
 Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
References: <20240909084745.2029818-2-cassel@kernel.org>
 <bd4d7454-2b34-46d8-9b88-0811bd478551@kernel.org>
 <Zt7zQF0fLxEY0G2T@ryzen.lan>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zt7zQF0fLxEY0G2T@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 22:08, Niklas Cassel wrote:
> On Mon, Sep 09, 2024 at 09:52:53PM +0900, Damien Le Moal wrote:
>> On 9/9/24 17:47, Niklas Cassel wrote:
>>> When ata_qc_complete() schedules a command for EH using
>>> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
>>> req->q->mq_ops->timeout() / scsi_timeout() being called.
>>>
>>> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
>>> handler), will set host byte to DID_TIME_OUT, and then call
>>> scsi_eh_scmd_add() to add the command to EH.
>>>
>>> Thus, when commands first enter libata's EH strategy_handler, all the
>>> commands that have been added to EH will have DID_TIME_OUT set.
>>>
>>> libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
>>> have not received a completion at the time of entering EH.
>>>
>>> Thus, libata doesn't really care about DID_TIME_OUT at all, and currently
>>> clears the host byte at the end of EH, in ata_scsi_qc_complete(), before
>>> scsi_eh_finish_cmd() is called.
>>>
>>> However, this clearing in ata_scsi_qc_complete() is currently only done
>>> for commands that are not ATA passthrough commands.
>>>
>>> Since the host byte is visible in the completion that we return to user
>>> space for ATA passthrough commands, for ATA passthrough commands that got
>>> completed via EH (commands with sense data), the user will incorrectly see:
>>> ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]
>>>
>>> Fix this by moving the clearing of the host byte (which is currently only
>>> done for commands that are not ATA passthrough commands) from
>>> ata_scsi_qc_complete() to the start of EH (regardless if the command is
>>> ATA passthrough or not).
>>>
>>> This will make sure that we:
>>> -Correctly clear DID_TIME_OUT for both ATA passthrough commands and
>>>  commands that are not ATA passthrough commands.
>>> -Do not needlessly clear the host byte for commands that did not go via EH.
>>>  ata_scsi_qc_complete() is called both for commands that are completed
>>>  normally (without going via EH), and for commands that went via EH,
>>>  however, only commands that went via EH will have DID_TIME_OUT set.
>>>
>>> Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
>>> Reported-by: Igor Pylypiv <ipylypiv@google.com>
>>> Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/
>>> Tested-by: Igor Pylypiv <ipylypiv@google.com>
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>> ---
>>> Changes since v1:
>>> -Picked up tags from Igor.
>>> -Added Fixes tag.
>>> -Improved the commit message to clearly state that this is currently a
>>>  real bug for ATA PT commands with sense data.
>>>
>>>  drivers/ata/libata-eh.c   | 9 +++++++++
>>>  drivers/ata/libata-scsi.c | 3 ---
>>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 7de97ee8e78b..450e9bd96c97 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -630,6 +630,15 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>>  	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>>>  		struct ata_queued_cmd *qc;
>>>  
>>> +		/*
>>> +		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
>>> +		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
>>> +		 * have set DID_TIME_OUT (since libata does not have an abort
>>> +		 * handler). Thus to clear the DID_TIME_OUT, we clear the host
>>> +		 * byte (but keep the SCSI ML and status byte).
>>> +		 */
>>> +		scmd->result &= 0x0000ffff;
>>
>> I know it was like that, but why not:
>>
>> 		set_host_byte(scmd, 0);
>> or
>> 		set_host_byte(scmd, DID_OK);
>>
>> ?
> 
> No particular reason. Since we basically just moving the code,
> it made sense to keep it similar to the original code, but I
> can submit a v3 that instead does:
> set_host_byte(scmd, DID_OK);
> 
> if you prefer that.

I do prefer it. The magic 0x0000ffff mask is not exactly clear (the comment
helps though)...

Side note: patching scsi to define macros for status, ML and host byte masks and
shifts would be very nice :)

> 
> Strictly speaking, that would probably require us to drop Igor's
> Tested-by though (even if the generated code for an optimizing
> compiler ought to generate the same code).
> 
> 
>>
>> set_host_byte() uses the mask 0xff00ffff, since the upper 8 bits seem to be
>> ignored: bits [0..7] are the status byte, [16..23] are the host byte and bits
>> [8..15] are the message byte but that is unused.
> 
> Nit: 8..16 is the SCSI midlayer byte, not message byte, see
> 36ebf1e2aa14 ("scsi: core: Add error codes for internal SCSI midlayer use")
> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

