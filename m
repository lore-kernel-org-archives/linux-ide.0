Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECB35F8AB
	for <linux-ide@vger.kernel.org>; Fri,  5 Dec 2025 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919901; cv=none; b=Z8l3oh3Qf+aB4Dq65bhkIZJY8c2qaRJFEWe/eNBdUuMgD5V7tT23zebCUm2uBgwefvJ3z/Ibk5jRRtq3z9NJh2GC4oQ7XSoF/RX8frtFqtaDtd/8V3AJLQrOiVt1x5RvSBfTR1KpsMs6iOCwkFc6Ups84totv/yPaaKP5DM3z4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919901; c=relaxed/simple;
	bh=EEFj0lHwfQalDdokwFQwCbpaiCmBIQp/PefGZ5APEkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wpt/WNEiqmE5kysjBOwR8ttCUEETf7vwD+il0aCGrIy6pJcgtPjQyfh4IToyU2H7Y9TF0RpTWTtv9HO8ndlbUimVeL/VXi2lxOsGZ5BxSz8Lx5X6CusPkb1yZ/Xblrxbz96TmKJmwsrNKdhHEbvLEORuURoLxlMI0GAGSLVgDoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A3Ewwfrn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AIXfXuNh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aOo2Kifx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xrs4TFBg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A3Ewwfrn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AIXfXuNh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aOo2Kifx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xrs4TFBg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2330F336CA;
	Fri,  5 Dec 2025 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764919881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptHwRQ1lQuq+mavqdT3mJprj7JYUbbsx4x/CJKm4E0=;
	b=A3EwwfrnSxURVt9CZCGGO2IZKEo+Le+JILf5ncxCITgouVFEETUOPmYXj+fahI1vPrCJYo
	Fbs2I2Fw4ZqsmjQhUjE5U/9V6ZNpZmQaVQDoGaG6MBXdLt7SHx92EideUXiyu48qktp3Cs
	p1V/s4AkLmyheuK7rLJXlw8oGajT5tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764919881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptHwRQ1lQuq+mavqdT3mJprj7JYUbbsx4x/CJKm4E0=;
	b=AIXfXuNh6pVevq092Pcnw1xq1RpqIskVSjdYSCTpzTFmEhIsU5KUXVQYZrA534K4OC/CIn
	TUpZjZ5B/dGpeTCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aOo2Kifx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xrs4TFBg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764919880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptHwRQ1lQuq+mavqdT3mJprj7JYUbbsx4x/CJKm4E0=;
	b=aOo2KifxkNUqKkfFjV+YDpaLLmFOrVtGf5X6VtpL7LR2YDIReDr0v2ewxhkVh2MJnm0nki
	uTbMapucXLf6df8wUSqLSjlOMjI8ADTxOwOV5TN4mUi28SD0BmaQ2WziYeMUP/DQvJElbf
	vnR2L1lNO4bGxtMMwUy4ujqcOy4l0Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764919880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptHwRQ1lQuq+mavqdT3mJprj7JYUbbsx4x/CJKm4E0=;
	b=xrs4TFBgHr4LJrJBk5ebSeXfcJieC9ymkSV8ZTi6Po9lzdZNsGwJdFZj96wAYKPapdrHO1
	yFRieyIVzo3eT7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00ACA3EA63;
	Fri,  5 Dec 2025 07:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRDgOUeKMmkMBQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 05 Dec 2025 07:31:19 +0000
Message-ID: <7b1b0cb2-bb57-4131-b390-b42331f51ae3@suse.de>
Date: Fri, 5 Dec 2025 08:31:19 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: Remove superfluous local_irq_save()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20251204131804.946417-2-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251204131804.946417-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 2330F336CA
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 12/4/25 14:18, Niklas Cassel wrote:
> Commit 28a3fc2295a7 ("libata: implement ZBC IN translation") added
> ata_scsi_report_zones_complete(). Since the beginning, this function
> has disabled IRQs on the local CPU using local_irq_save().
> 
> qc->complete_fn is always called with ap->lock held, and the ap->lock
> is always taking using spin_lock_irq*().
> 
> Thus, this local_irq_save() is superfluous and can be removed.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 434774e71fe61..86d283d340e32 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3572,13 +3572,13 @@ static void ata_scsi_report_zones_complete(struct ata_queued_cmd *qc)
>   {
>   	struct scsi_cmnd *scmd = qc->scsicmd;
>   	struct sg_mapping_iter miter;
> -	unsigned long flags;
>   	unsigned int bytes = 0;
>   
> +	lockdep_assert_held(qc->ap->lock);
> +
>   	sg_miter_start(&miter, scsi_sglist(scmd), scsi_sg_count(scmd),
>   		       SG_MITER_TO_SG | SG_MITER_ATOMIC);
>   
> -	local_irq_save(flags);
>   	while (sg_miter_next(&miter)) {
>   		unsigned int offset = 0;
>   
> @@ -3626,7 +3626,6 @@ static void ata_scsi_report_zones_complete(struct ata_queued_cmd *qc)
>   		}
>   	}
>   	sg_miter_stop(&miter);
> -	local_irq_restore(flags);
>   
>   	ata_scsi_qc_complete(qc);
>   }

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
