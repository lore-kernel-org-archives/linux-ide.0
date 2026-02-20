Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD82AD3D;
	Fri, 20 Feb 2026 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549576; cv=none; b=URAScQMpTqh/m8CzBXJq2EdMij/AMTsQmGovdSPFmAbP3GJDpNChMfvphrCoPkrSe2+kHAyfN63mlmdzzTwU2CS3viQ3N3N1oqRkxj0Ndhj7LS9rnt0DGQKBwZBsDtPDZzuYkCQA0Ik8+3pubrMu/qQjNptafgtI9UkW60QoirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549576; c=relaxed/simple;
	bh=wyZ+hYxm5spP+EB9wuXJuo1imqRgN4Uex8hMGzBwdUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgUFhl+dX7xM7DkIa7NnBhydUDPhtR185HgGvmkDimsLBNu4HIWmzBrq+H8eD+JZAwyaz70dPHCtfErmHTNrUAgibrzgkPUF3L35x0k7Gm0IHgbwAJg2GSOc+O/6a/jge2HN5K7Iy+HbcDIEU5zTxikSWT1tuXGtehf47KMTnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoGTLlZe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoGTLlZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B110AC4CEF7;
	Fri, 20 Feb 2026 01:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771549575;
	bh=wyZ+hYxm5spP+EB9wuXJuo1imqRgN4Uex8hMGzBwdUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZoGTLlZeYaVC0436PrPSXd/lxbc6kue/IK8iIRx22zadJUgXzHXMyDboi2VUreegw
	 /Hj8KYgAte4hCUqH2EHU2ov3rp9Dni9lHn8d8XrN0cJqymWp7xBn+3LxSHrf45DtWp
	 BSxBoUNt1CAIj2ENBvoWsmcVz8NWr6BzwvxCA/M5cfdm4/mu9TCOfAJZ48dPpnGGlM
	 6+WhBMa7b2EmK2uIt5yRYRjcQIaKf8BFPCrKAAjG7zakdktGCYdVD3sRpKb9XDgLf2
	 ldB+7k4/XDBooQi+CvAy5juWLfYvIQO2sdM33RByJDzAMnDJNw819rNQCX5dPx+rQ/
	 6W90Vub4Zrg7A==
Message-ID: <d49ebdba-9925-414f-8889-877adbad6052@kernel.org>
Date: Fri, 20 Feb 2026 10:06:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
To: Niklas Cassel <cassel@kernel.org>
Cc: syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com>
 <aZWKRkTVIJuLS_Y7@ryzen> <1e4e903b-143f-4f95-a41d-2a87cdcaf2c4@kernel.org>
 <aZeubyGHf1GX0HPA@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aZeubyGHf1GX0HPA@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/26 09:55, Niklas Cassel wrote:
> On Thu, Feb 19, 2026 at 10:33:22AM +0900, Damien Le Moal wrote:
>>>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
>>>> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
>>>
>>> 4210818301 is 0xfafbfcfd
>>>
>>> 0xfafbfcfd is ATA_TAG_POISON.
>>>
>>> ATA_TAG_POISON is set by ata_qc_free(), so it appears that
>>> ata_scsi_deferred_qc_work() is trying to issue a QC that has
>>> already been freed.
>>
>> I checked the code but I fail to see any path that can lead to this happening.
>> I did more tests using qemu q35 machine as used by syzbot, and everything looks
>> fine. So not sure what is happening here. I will dig further.
> 
> Hello Damien,
> 
> 
> My best guess:
> since qc->tag is ATA_TAG_POISON, ata_qc_free() must have been called
> on ap->deferred_qc.
> 
> If it was an NCQ abort, ata_eh_set_pending() would have been called to
> clear ap->deferred_qc. Since ap->deferred_qc is apparently set, it
> appears that we did not get an error IRQ.
> 
> To me, that leaves a timeout as the most likely scenario.

Good point. I think the timeout case was completely overlooked...
That should be fairly easy to debug: I just need to add have the deferred work
do nothing to see the deferred qc timeout.

Let me hack something and come up with a fix.

> 
> I.e. SCSI EH is called without ata_eh_set_pending() having been called.
> (Currently ata_eh_set_pending() is the function that clears
> ap->deferred_qc)
> 
> 
> 
> If I look at ata_scsi_cmd_error_handler() it will only break if:
> 
> if (qc->flags & ATA_QCFLAG_ACTIVE && qc->scsicmd == scmd)
> 
> If the deferred QC times out, flag ATA_QCFLAG_ACTIVE will not be set
> (because ATA_QCFLAG_ACTIVE is only set by qc_issue()).
> 
> Since ATA_QCFLAG_ACTIVE is not set i == ATA_MAX_QUEUE, so we will enter the
> else clause which calls:
> scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> 
> 
> That might potentially free the tag to the block layer to reuse,
> while ap->deferred_qc is still set (with the same tag).
> 
> Possibly, next time ata_scsi_qc_issue() is called, ap->deferred_qc is still set,
> so it calls ata_qc_free(qc), which, since it wasn't cleared, might have the same
> tag? because block layer has now reused the tag (since SCSI completed the
> command).
> 
> I would possibly have expected some kind of print from SCSI in this case.
> (But since the else clause finishes the command normally, perhaps not?)
> 
> But perhaps it is wise to add some code to ata_scsi_cmd_error_handler()
> which clears ap->deferred_qc.
> 
> 
> 
> Another possibility... again, timed out commands will not have called
> ata_eh_set_pending(). scsi_timeout() will call scsi_abort_command()
> which will queue delayed work, and the worker function scmd_eh_abort_handler()
> will call scsi_eh_scmd_add(), which calls
> scsi_host_set_state(shost, SHOST_RECOVERY).
> 
> We did add a guard in libata in commit e20e81a24a4d ("ata: libata-core: do not
> issue non-internal commands once EH is pending"), so that we will defer commands
> even when EH is pending. But in the case of timeout, there will be no error IRQ,
> so we will not do an early return in __ata_scsi_queuecmd(), so we could set
> qc->deferred_qc up until the worker function scmd_eh_abort_handler() has called
> scsi_host_set_state(shost, SHOST_RECOVERY).
> 
> Again, adding some code to ata_scsi_cmd_error_handler() to clear ap->deferred_qc
> should handle this case.
> 
> 
> I would probably hack some QEMU to not send a reply, so that we will get block
> layer timeouts, because right now, ata_scsi_cmd_error_handler() seems like the
> most likely problematic code to me.
> 
> 
> Kind regards,
> Niklas
> 


-- 
Damien Le Moal
Western Digital Research
