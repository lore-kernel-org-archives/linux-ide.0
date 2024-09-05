Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9001898E4;
	Thu,  5 Sep 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525223; cv=none; b=HB7kblshEAJloxE9qNccnUfi/jVKeo7FmXfDkBcit65CFHixyj4S0s/tz4sgIlXh8KECZH9gJIgQAbEsIT7N+vXRCGX6dh2YBiSYd0BAtrdX11s101koneXigT0kHnjHjeG7OMktBbvYdCo3AEjJKTrFSfMA0Z19RzFGIvTC4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525223; c=relaxed/simple;
	bh=5Kce66BoEzhRGGCAESwM3bAZjGKtJPGCv8Uo03s2PIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp8acyRq4W/gK6RxN1SvGyKLxgFy5+5SjxYnQyBBXP8DoSqW22lHgXjwNlLuKJfPpE6b+6fQ8+m6VnK/Ys5VyQb5lzZMCyrYMiYsgVl180HiWezLbpvD2IhN1px2YyJkPgwT0l4Ci/R97Drn306SrnuIwBoRNvw/p7CSMtD97/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMO47Wgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMO47Wgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ECFC4CEC3;
	Thu,  5 Sep 2024 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725525223;
	bh=5Kce66BoEzhRGGCAESwM3bAZjGKtJPGCv8Uo03s2PIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMO47Wgv82i87rGl7EqWh4tt/Oh8xQTnJLZlAO6yBzXLmHTqXtHHBl2Vu3PkhrIeP
	 OeY5gsZrEMLC6Kvf+P8QP+ASlK01jJDjCrf4dpLb8a8jeqkAUqadm+TDwJoar1CdmL
	 KPPNt8JvgQnVaq3GZ5XENoZT8HAdzYWV1vQrLaBhHitH80WlOpFz42QFOamgrLYKNX
	 RbHOOoT6GHT99xGSLckNa1FE4cEFnaPMzriOQo4zIWcGqGvrCSTvLKBC/Q07kMEibC
	 Rf9r52yfi3RP3Dq9CziePEsWV62HhxgjmJfVNjzZgkCFDndP3Mu8eBysXnbDmNVRtW
	 CQp7N8geOYrFA==
Date: Thu, 5 Sep 2024 10:33:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Clear scsicmd->result when setting
 SAM_STAT_CHECK_CONDITION
Message-ID: <Ztls4mim6Jky7E0S@ryzen.lan>
References: <20240904223727.1149294-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904223727.1149294-1-ipylypiv@google.com>

Hello Igor,

On Wed, Sep 04, 2024 at 10:37:27PM +0000, Igor Pylypiv wrote:
> commit 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to
> not set CHECK_CONDITION") changed the way how SAM_STAT_CHECK_CONDITION is
> set. Assignment "scmd->result = SAM_STAT_CHECK_CONDITION;" was replaced by
> set_status_byte() which does not clear the scsicmd->result.

"which does not clear the scsicmd->result"

scsicmd->result is a combination of:
-SCSI status byte
-SCSI ML byte
-host byte

Please be more specific of which byte(s) that you want to clear,
both here and in other places in the commit message.


> 
> By not clearing the scsicmd->result we end up in a state where both
> the DID_TIME_OUT host byte and the SAM_STAT_CHECK_CONDITION status
> bytes are set.
> 


> The DID_TIME_OUT host byte is getting set a part of error handling:
> 
> ata_qc_complete()
>     ata_qc_schedule_eh()
>         blk_abort_request()
>             WRITE_ONCE(req->deadline, jiffies);
> 
> blk_mq_timeout_work()
>     blk_mq_check_expired()
>         blk_mq_rq_timed_out()
> 	    req->q->mq_ops->timeout() / scsi_timeout()
>                 set_host_byte(scmd, DID_TIME_OUT);

I would have reorder your commit log and have this first in the commit log.


> 
> Having the host byte set to DID_TIME_OUT for a command that didn't timeout
> is confusing. Let's bring the old behavior back by setting scmd->result to
> SAM_STAT_CHECK_CONDITION.

I think you are missing something very important in the commit log here:
What is the user visible change before and after your change?

Is there a difference is the error message in dmesg? If not, that should
be mentioned as well.


> 
> Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-eh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 214b935c2ced..4927b40e782f 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1605,7 +1605,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
>  		 */
>  		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID) &&
>  		    (stat & ATA_SENSE) && ata_eh_request_sense(qc))
> -			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> +			qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;

ata_eh_analyze_tf() will only be called on commands that are owned by EH
(has ATA_QCFLAG_EH set).

Thus this command will end up in:
ata_eh_finish() -> ata_eh_qc_complete() -> __ata_eh_qc_complete() ->
-> __ata_qc_complete() -> qc->complete_fn().

complete_fn will be (except in special cases): ata_scsi_qc_complete()
If you look at ata_scsi_qc_complete(), it already clears the host byte:
https://github.com/torvalds/linux/blob/v6.11-rc6/drivers/ata/libata-scsi.c#L1695-L1696

So could you please be more specific of what problem this change is fixing?
Is it just that you think that it makes sense to clear the host byte earlier
in the call chain?

There are many different paths a QC can take via EH, e.g. policy 0xD NCQ
commands will not fetch sense data via ata_eh_request_sense(), so clearing
the host byte in ata_scsi_qc_complete() should be fine, otherwise we need
to do a similar change to yours in all the different code paths that sets
sense data ...which might actually be something that makes sense, but then
I would expect a patch series that changes all the locations where we set
sense data, not just in ata_eh_analyze_tf(), and then drops the clearing in
ata_scsi_qc_complete() (which was introduced in commit 7574a8377c7a ("ata:
libata-scsi: do not overwrite SCSI ML and status bytes")).


See this patch to see all the places where we set sense data:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=for-6.12&id=9526dec226f0779d72f798e7a18375bf8d414775




Side note:
You might also be interested to know that a command that was sent via EH will
be finished using scsi_eh_finish_cmd() (called by __ata_eh_qc_complete()),
and will thus end up in scsi_eh_flush_done_q(). A command that has sense data
will have scmd->retries == scmd->allowed (set by ata_eh_qc_complete()), so you
will end up in this code path:
https://github.com/torvalds/linux/blob/v6.11-rc6/drivers/scsi/scsi_error.c#L2213-L2227

Which means that SCSI EH will set DID_TIME_OUT for any command that does
not have (SCSI ML byte || SCSI status byte || host byte) set.

A command with sense data will have most often have CHECK_CONDITION set, but
there is also CDL policy 0xD commands (which will have the SCSI ML byte set).
So this special flag SCMD_FORCE_EH_SUCCESS is for commands that were completed
successfully without any SK/ASC/ASCQ in the same interrupt as other policy 0xD
commands which did have SK/ASC/ASCQ set.
For details, see 3d848ca1ebc8 ("scsi: core: Allow libata to complete successful
commands via EH").


Kind regards,
Niklas
