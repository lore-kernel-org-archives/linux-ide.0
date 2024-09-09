Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB321BAEE2
	for <linux-ide@vger.kernel.org>; Mon,  9 Sep 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887301; cv=none; b=mGc288Zi4SEol7veShobOIe61oRl+UZ1ya8tFe/ZqYNsdXlTG3HTrKSbviZDZoCAuy8REkRlc6Txg8ZiPZh4LuJP52PXGhiLm7OguzheZmrNvV8dVvsa914FBe9NKcruXsl9uKaHEndLg6/k+I0dUG8CdPbzim/v1Ot/8JzKfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887301; c=relaxed/simple;
	bh=qVvMjTit7faTRBP634Ah3jXBREb/LKANXu+2KneuQLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jATrDJBhDuNPV+yfZQRFxae44Mqe1ZiLZc2ZLkZUmyq8yObjf0qDFC+v8hH7fZ5+1bc/6ATwd9D2UWugWTIAH8adp5bwg6ZTlj3cd57UqswINOdRUwf/1/MeMVVsQcoDly3bmNjtpyoUPv96t2M07CseEzCsPmTbZcA19rbFwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP9UnAOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP9UnAOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEAAC4CEC8;
	Mon,  9 Sep 2024 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725887301;
	bh=qVvMjTit7faTRBP634Ah3jXBREb/LKANXu+2KneuQLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gP9UnAOOsuk7woKXjiDzLmksT9+wr84TtpXyn6T7zRZsHhR+O/Z+ixk06Ns2UHryQ
	 Cb8X1qI+xxCAPvQfZ+qCdZ9L5E7BFHKbPcX8RZwrSMhYRCuHo1fTZ25kGIx7LHA4Ix
	 7pxeJCMTXY5fpwQjDdJz0APXKVWNvhcPGKyadVE0YBYVzydCfX7qTjGZHfzgvLAt0Z
	 UWrqdETjxzt9aL9oAaw5DPdGp4nK6DIgfLks2hJtbEUbtZsKubsOzjQYxwAAM4xklu
	 S2iw7YvLaVJmpnYXoGEgWqRhmp127JBRFKo+IKj4AX98OQhFaoFTGGWPeY8rVpCmhR
	 TDx9LEWETnctw==
Date: Mon, 9 Sep 2024 15:08:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <Zt7zQF0fLxEY0G2T@ryzen.lan>
References: <20240909084745.2029818-2-cassel@kernel.org>
 <bd4d7454-2b34-46d8-9b88-0811bd478551@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd4d7454-2b34-46d8-9b88-0811bd478551@kernel.org>

On Mon, Sep 09, 2024 at 09:52:53PM +0900, Damien Le Moal wrote:
> On 9/9/24 17:47, Niklas Cassel wrote:
> > When ata_qc_complete() schedules a command for EH using
> > ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> > req->q->mq_ops->timeout() / scsi_timeout() being called.
> > 
> > scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> > handler), will set host byte to DID_TIME_OUT, and then call
> > scsi_eh_scmd_add() to add the command to EH.
> > 
> > Thus, when commands first enter libata's EH strategy_handler, all the
> > commands that have been added to EH will have DID_TIME_OUT set.
> > 
> > libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
> > have not received a completion at the time of entering EH.
> > 
> > Thus, libata doesn't really care about DID_TIME_OUT at all, and currently
> > clears the host byte at the end of EH, in ata_scsi_qc_complete(), before
> > scsi_eh_finish_cmd() is called.
> > 
> > However, this clearing in ata_scsi_qc_complete() is currently only done
> > for commands that are not ATA passthrough commands.
> > 
> > Since the host byte is visible in the completion that we return to user
> > space for ATA passthrough commands, for ATA passthrough commands that got
> > completed via EH (commands with sense data), the user will incorrectly see:
> > ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]
> > 
> > Fix this by moving the clearing of the host byte (which is currently only
> > done for commands that are not ATA passthrough commands) from
> > ata_scsi_qc_complete() to the start of EH (regardless if the command is
> > ATA passthrough or not).
> > 
> > This will make sure that we:
> > -Correctly clear DID_TIME_OUT for both ATA passthrough commands and
> >  commands that are not ATA passthrough commands.
> > -Do not needlessly clear the host byte for commands that did not go via EH.
> >  ata_scsi_qc_complete() is called both for commands that are completed
> >  normally (without going via EH), and for commands that went via EH,
> >  however, only commands that went via EH will have DID_TIME_OUT set.
> > 
> > Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> > Reported-by: Igor Pylypiv <ipylypiv@google.com>
> > Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/
> > Tested-by: Igor Pylypiv <ipylypiv@google.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v1:
> > -Picked up tags from Igor.
> > -Added Fixes tag.
> > -Improved the commit message to clearly state that this is currently a
> >  real bug for ATA PT commands with sense data.
> > 
> >  drivers/ata/libata-eh.c   | 9 +++++++++
> >  drivers/ata/libata-scsi.c | 3 ---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 7de97ee8e78b..450e9bd96c97 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -630,6 +630,15 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
> >  	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> >  		struct ata_queued_cmd *qc;
> >  
> > +		/*
> > +		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
> > +		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
> > +		 * have set DID_TIME_OUT (since libata does not have an abort
> > +		 * handler). Thus to clear the DID_TIME_OUT, we clear the host
> > +		 * byte (but keep the SCSI ML and status byte).
> > +		 */
> > +		scmd->result &= 0x0000ffff;
> 
> I know it was like that, but why not:
> 
> 		set_host_byte(scmd, 0);
> or
> 		set_host_byte(scmd, DID_OK);
> 
> ?

No particular reason. Since we basically just moving the code,
it made sense to keep it similar to the original code, but I
can submit a v3 that instead does:
set_host_byte(scmd, DID_OK);

if you prefer that.

Strictly speaking, that would probably require us to drop Igor's
Tested-by though (even if the generated code for an optimizing
compiler ought to generate the same code).


> 
> set_host_byte() uses the mask 0xff00ffff, since the upper 8 bits seem to be
> ignored: bits [0..7] are the status byte, [16..23] are the host byte and bits
> [8..15] are the message byte but that is unused.

Nit: 8..16 is the SCSI midlayer byte, not message byte, see
36ebf1e2aa14 ("scsi: core: Add error codes for internal SCSI midlayer use")


Kind regards,
Niklas
