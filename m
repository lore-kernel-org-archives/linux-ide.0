Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D71EA6F
	for <linux-ide@vger.kernel.org>; Mon,  9 Sep 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886375; cv=none; b=HR+7HFQaOKfR+ueOn0TE7KMPGoJCj/hqE+6KdU1y6UG+3w56dcAEN5J3RFOaOOmzSQYGbG2l85O2xE1SffDGpjgrIQdLTtZX9ZDHaSc5TtXWj6NCXvRgYatXXVRNFkE63S53EBOCyRsSG6wciToAR56usCdjFA431kbu8FDpVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886375; c=relaxed/simple;
	bh=TZlZh9bRHb0y5vhlPbUK8MfVKoGAq0S1f+3xw1F18vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpYhPZTpm5HhQoySD0JCz6Y/oIyz3r+6SCdGNF30lvEz6ukWmZrBklHVtOku3H2Yp8vjAjNiETK40HrXcti/DQ5hhHP/OLwHwWTCUGZ2xDSyXEApvm/Y1YREzf2K40u5E1zRqfDU/6hko2Ty1YctfJXMBa7eY2OVJ/nSl5ppEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2H4X4+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2H4X4+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94FC4CEC6;
	Mon,  9 Sep 2024 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886375;
	bh=TZlZh9bRHb0y5vhlPbUK8MfVKoGAq0S1f+3xw1F18vE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m2H4X4+TkdZa/xoUZe+FaWisRgJbbKfsaZpgIElOGT7jYcqnGhgIJfVxZsR8CmkWA
	 4O6sxLufa6T1vWxRsw5rKXd557eYBpovxpwcsvYcK+sQr9KH5Lyl/o3R2IZP5Vurd5
	 280P0r/XzzxX+Q/ZvjwCEZXqeu1EdabOswlbaT/fCoBQEgjh8by3Uun517aQAo2X6k
	 b85Kti+Ku6ewyLjk7bD34BGFdmy+F02ciduj1a2f7T16ObVwahoYgUJCDT81E21j50
	 E8uIK1+j4mKsFZhCCavSOH5JKYEmQw30M9CrHWUcsKyBm0EuSpNTovODfdeZll+IcR
	 Oi6zPup3DM0Ew==
Message-ID: <bd4d7454-2b34-46d8-9b88-0811bd478551@kernel.org>
Date: Mon, 9 Sep 2024 21:52:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
To: Niklas Cassel <cassel@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
Cc: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel
 <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
References: <20240909084745.2029818-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240909084745.2029818-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 17:47, Niklas Cassel wrote:
> When ata_qc_complete() schedules a command for EH using
> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> req->q->mq_ops->timeout() / scsi_timeout() being called.
> 
> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> handler), will set host byte to DID_TIME_OUT, and then call
> scsi_eh_scmd_add() to add the command to EH.
> 
> Thus, when commands first enter libata's EH strategy_handler, all the
> commands that have been added to EH will have DID_TIME_OUT set.
> 
> libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
> have not received a completion at the time of entering EH.
> 
> Thus, libata doesn't really care about DID_TIME_OUT at all, and currently
> clears the host byte at the end of EH, in ata_scsi_qc_complete(), before
> scsi_eh_finish_cmd() is called.
> 
> However, this clearing in ata_scsi_qc_complete() is currently only done
> for commands that are not ATA passthrough commands.
> 
> Since the host byte is visible in the completion that we return to user
> space for ATA passthrough commands, for ATA passthrough commands that got
> completed via EH (commands with sense data), the user will incorrectly see:
> ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]
> 
> Fix this by moving the clearing of the host byte (which is currently only
> done for commands that are not ATA passthrough commands) from
> ata_scsi_qc_complete() to the start of EH (regardless if the command is
> ATA passthrough or not).
> 
> This will make sure that we:
> -Correctly clear DID_TIME_OUT for both ATA passthrough commands and
>  commands that are not ATA passthrough commands.
> -Do not needlessly clear the host byte for commands that did not go via EH.
>  ata_scsi_qc_complete() is called both for commands that are completed
>  normally (without going via EH), and for commands that went via EH,
>  however, only commands that went via EH will have DID_TIME_OUT set.
> 
> Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
> Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/
> Tested-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1:
> -Picked up tags from Igor.
> -Added Fixes tag.
> -Improved the commit message to clearly state that this is currently a
>  real bug for ATA PT commands with sense data.
> 
>  drivers/ata/libata-eh.c   | 9 +++++++++
>  drivers/ata/libata-scsi.c | 3 ---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7de97ee8e78b..450e9bd96c97 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -630,6 +630,15 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>  		struct ata_queued_cmd *qc;
>  
> +		/*
> +		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
> +		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
> +		 * have set DID_TIME_OUT (since libata does not have an abort
> +		 * handler). Thus to clear the DID_TIME_OUT, we clear the host
> +		 * byte (but keep the SCSI ML and status byte).
> +		 */
> +		scmd->result &= 0x0000ffff;

I know it was like that, but why not:

		set_host_byte(scmd, 0);
or
		set_host_byte(scmd, DID_OK);

?

set_host_byte() uses the mask 0xff00ffff, since the upper 8 bits seem to be
ignored: bits [0..7] are the status byte, [16..23] are the host byte and bits
[8..15] are the message byte but that is unused.
		

> +
>  		ata_qc_for_each_raw(ap, qc, i) {
>  			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>  			    qc->scsicmd == scmd)
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3a442f564b0d..6a90062c8b55 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
>  	} else if (is_error && !have_sense) {
>  		ata_gen_ata_sense(qc);
> -	} else {
> -		/* Keep the SCSI ML and status byte, clear host byte. */
> -		cmd->result &= 0x0000ffff;
>  	}
>  
>  	ata_qc_done(qc);

-- 
Damien Le Moal
Western Digital Research

