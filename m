Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C40178389
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948382; cv=none; b=lnkQDHPqYRbiY4aBrX0wWH6RMOXLHU9s6PA5HnG1tU6/WDdOXvuyQevPUPATHfgh060keXm2i/Hqs0vkFduKQikUgOy2LTcFk3xsIGeDfrCC79gO04PjSxZ8XlpJBBHxkusTOVxGKBCQj5VA1RNrhxTltfwDsUi0Kojbc6gTDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948382; c=relaxed/simple;
	bh=OujWX4tzZc/C8Cie1ng8IsDpHa3TpDD8O4kiOfZKv70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9MWNXmZWIEO4RX4YmUQniQb1S52h3Qd5uHiAWceCx9IKL9o9CrU4GTGKQhAwaFUkR+YobgE32txJhYYlZAilALsW84i5usuwayawrrIyw5bT+Nn7x+rnt/A+46PRZEfU9JcBF067QgW/mqBvb+Dde80jo++mJ80O4Q7l3HqPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=icp9saLf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DnKoUq4s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=icp9saLf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DnKoUq4s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="icp9saLf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DnKoUq4s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="icp9saLf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DnKoUq4s"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41B6321A58;
	Tue, 10 Sep 2024 06:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725948378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgMm1PuWrwqIY4Cz1xg/lPZRvpD+1ca9PZEWjbByrtI=;
	b=icp9saLfHCQr1BTgZuI39l0+jMJ3fCQuUTX2RtQD1RQsZ0Eee562XH298QXacIoOIQD+mB
	xi52OmGTWCw0CNPtrxOpMxImpTfcC9VlRUms2ZCBT5rERfp+s4ceI7O8ia3JtGk7vWH88Z
	1FrwtlP4XlZmZAhzbUpn0FTH6bbj6M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725948378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgMm1PuWrwqIY4Cz1xg/lPZRvpD+1ca9PZEWjbByrtI=;
	b=DnKoUq4sM2IPpEjn5hAnm5GtaVvPb/ura3jZAAVxIWhFIN/Fi+BmCAVEedBQ6Zyel73WMg
	SzWIFr1P5LK77UAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725948378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgMm1PuWrwqIY4Cz1xg/lPZRvpD+1ca9PZEWjbByrtI=;
	b=icp9saLfHCQr1BTgZuI39l0+jMJ3fCQuUTX2RtQD1RQsZ0Eee562XH298QXacIoOIQD+mB
	xi52OmGTWCw0CNPtrxOpMxImpTfcC9VlRUms2ZCBT5rERfp+s4ceI7O8ia3JtGk7vWH88Z
	1FrwtlP4XlZmZAhzbUpn0FTH6bbj6M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725948378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgMm1PuWrwqIY4Cz1xg/lPZRvpD+1ca9PZEWjbByrtI=;
	b=DnKoUq4sM2IPpEjn5hAnm5GtaVvPb/ura3jZAAVxIWhFIN/Fi+BmCAVEedBQ6Zyel73WMg
	SzWIFr1P5LK77UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11136132CB;
	Tue, 10 Sep 2024 06:06:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G+96Atrh32aNDwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Sep 2024 06:06:18 +0000
Message-ID: <f75e8065-ab16-41ca-ab03-2fea3bf6134d@suse.de>
Date: Tue, 10 Sep 2024 08:06:17 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel
 <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
References: <20240909154237.3656000-2-cassel@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240909154237.3656000-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 9/9/24 17:42, Niklas Cassel wrote:
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
> While at it, use the proper helper function to clear the host byte, rather
> than open coding the clearing.
> 
> This will make sure that we:
> -Correctly clear DID_TIME_OUT for both ATA passthrough commands and
>   commands that are not ATA passthrough commands.
> -Do not needlessly clear the host byte for commands that did not go via EH.
>   ata_scsi_qc_complete() is called both for commands that are completed
>   normally (without going via EH), and for commands that went via EH,
>   however, only commands that went via EH will have DID_TIME_OUT set.
> 
> Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
> Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v2: use set_host_byte() as suggested by Damien.
> 
>   drivers/ata/libata-eh.c   | 8 ++++++++
>   drivers/ata/libata-scsi.c | 3 ---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7de97ee8e78b..703f5ce26765 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -630,6 +630,14 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>   	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>   		struct ata_queued_cmd *qc;
>   
> +		/*
> +		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
> +		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
> +		 * have set DID_TIME_OUT (since libata does not have an abort
> +		 * handler). Thus, to clear DID_TIME_OUT, clear the host byte.
> +		 */
> +		set_host_byte(scmd, DID_OK);
> +
>   		ata_qc_for_each_raw(ap, qc, i) {
>   			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>   			    qc->scsicmd == scmd)
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3a442f564b0d..6a90062c8b55 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>   			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
>   	} else if (is_error && !have_sense) {
>   		ata_gen_ata_sense(qc);
> -	} else {
> -		/* Keep the SCSI ML and status byte, clear host byte. */
> -		cmd->result &= 0x0000ffff;
>   	}
>   
>   	ata_qc_done(qc);

So all these accessors have not been in vain ...

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

