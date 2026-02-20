Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7202AD3D;
	Fri, 20 Feb 2026 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548944; cv=none; b=UK3/HxxY36UxR0WfFEo8S+40tiPCEOSk143gRKFfp+UTiy3lORxwijqFltKMBOfsD/AuoFd7zZ2WYX7MtVlzITq3rbTPPqxbdUYoLHYXXkgC5xJZLpDqWigqYbzREWozkkXZ7/gwDJPqvnEBGAej0Q+UWfc2mSiSQ+btU9tuWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548944; c=relaxed/simple;
	bh=N/RR2wn98KLCva+VWsJQV7J+Oneg6/c29w4xaWdcWtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6DdWQgkZDwL2mbu6dj3l8JWSs5/H5wsdFZWj+o7vIIJq4aVX7EhZUNU2Kn66N9VSf3J7K+vpRCCM0CXTgCu6JG1fqk72mi16JGYiu2684BSLo37n7gWPGh+KG91iIfMfWbcTtqN0L4BfiFZOA+91X6ZN9UENWDHCabSWKM5RyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/vAp0xO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/vAp0xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2AEC4CEF7;
	Fri, 20 Feb 2026 00:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771548944;
	bh=N/RR2wn98KLCva+VWsJQV7J+Oneg6/c29w4xaWdcWtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/vAp0xOq9y5QjbuovDmp45gGA6vaSlzb1AEnZp88tfqiFoQvFDO8d5pC0jBZDQNm
	 6EIomFJ2M/PDsbi8cIyHn17OkUB/wLxGz2YxyG92OU+tty1fh7n42Z3dBYQhDPf+KH
	 jppyRwoVbyH4yapsTMVJrhHMjC+BG0vrh9qzs1WJZQrZZYasVSoQz89Amri/m9v1F+
	 SJb6GCWYy/F8FHpLfdALiW3ahdpYvs9D5fi7o75VIkTBSE/yQ2b120HIsQdrtsafRo
	 O1z+g4Km1A50nsN7vY8Usy4pfLeHSkXfRvfFgnyTbEVXQORvolY5oOZEO4UTLm2XzZ
	 L8ITENprQTP8A==
Date: Fri, 20 Feb 2026 01:55:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
Message-ID: <aZeubyGHf1GX0HPA@ryzen>
References: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com>
 <aZWKRkTVIJuLS_Y7@ryzen>
 <1e4e903b-143f-4f95-a41d-2a87cdcaf2c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4e903b-143f-4f95-a41d-2a87cdcaf2c4@kernel.org>

On Thu, Feb 19, 2026 at 10:33:22AM +0900, Damien Le Moal wrote:
> >> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
> >> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
> > 
> > 4210818301 is 0xfafbfcfd
> > 
> > 0xfafbfcfd is ATA_TAG_POISON.
> > 
> > ATA_TAG_POISON is set by ata_qc_free(), so it appears that
> > ata_scsi_deferred_qc_work() is trying to issue a QC that has
> > already been freed.
> 
> I checked the code but I fail to see any path that can lead to this happening.
> I did more tests using qemu q35 machine as used by syzbot, and everything looks
> fine. So not sure what is happening here. I will dig further.

Hello Damien,


My best guess:
since qc->tag is ATA_TAG_POISON, ata_qc_free() must have been called
on ap->deferred_qc.

If it was an NCQ abort, ata_eh_set_pending() would have been called to
clear ap->deferred_qc. Since ap->deferred_qc is apparently set, it
appears that we did not get an error IRQ.

To me, that leaves a timeout as the most likely scenario.

I.e. SCSI EH is called without ata_eh_set_pending() having been called.
(Currently ata_eh_set_pending() is the function that clears
ap->deferred_qc)



If I look at ata_scsi_cmd_error_handler() it will only break if:

if (qc->flags & ATA_QCFLAG_ACTIVE && qc->scsicmd == scmd)

If the deferred QC times out, flag ATA_QCFLAG_ACTIVE will not be set
(because ATA_QCFLAG_ACTIVE is only set by qc_issue()).

Since ATA_QCFLAG_ACTIVE is not set i == ATA_MAX_QUEUE, so we will enter the
else clause which calls:
scsi_eh_finish_cmd(scmd, &ap->eh_done_q);


That might potentially free the tag to the block layer to reuse,
while ap->deferred_qc is still set (with the same tag).

Possibly, next time ata_scsi_qc_issue() is called, ap->deferred_qc is still set,
so it calls ata_qc_free(qc), which, since it wasn't cleared, might have the same
tag? because block layer has now reused the tag (since SCSI completed the
command).

I would possibly have expected some kind of print from SCSI in this case.
(But since the else clause finishes the command normally, perhaps not?)

But perhaps it is wise to add some code to ata_scsi_cmd_error_handler()
which clears ap->deferred_qc.



Another possibility... again, timed out commands will not have called
ata_eh_set_pending(). scsi_timeout() will call scsi_abort_command()
which will queue delayed work, and the worker function scmd_eh_abort_handler()
will call scsi_eh_scmd_add(), which calls
scsi_host_set_state(shost, SHOST_RECOVERY).

We did add a guard in libata in commit e20e81a24a4d ("ata: libata-core: do not
issue non-internal commands once EH is pending"), so that we will defer commands
even when EH is pending. But in the case of timeout, there will be no error IRQ,
so we will not do an early return in __ata_scsi_queuecmd(), so we could set
qc->deferred_qc up until the worker function scmd_eh_abort_handler() has called
scsi_host_set_state(shost, SHOST_RECOVERY).

Again, adding some code to ata_scsi_cmd_error_handler() to clear ap->deferred_qc
should handle this case.


I would probably hack some QEMU to not send a reply, so that we will get block
layer timeouts, because right now, ata_scsi_cmd_error_handler() seems like the
most likely problematic code to me.


Kind regards,
Niklas

