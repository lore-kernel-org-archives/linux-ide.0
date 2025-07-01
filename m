Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8625B687
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351129; cv=none; b=tBBG+3WBipIvPILzCwCxgMSgpgoKwLTpgBBobzXpSDDjbQlHBT6Yc4XeYTAndqAxIkJFOJPS92qNoZ81Sh0X93QIYGCKmRrkAjD2rnnv87TKorKeVwr4KMPqCczKIqnBc+EzFw4/smZqViatLH62gl6Mbtz0pDtCrb2ZMA2H8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351129; c=relaxed/simple;
	bh=GlCdUA9+bJYQbvNPJz6auX4j1a59MW+Akvha2EIPFPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HhfhYvXT1oUVsJP+hrAUjT3AYmM0qTJ8aXPt5fleKD38GPg43qc2Tf84qH7u95dj+7I9Xhwi2Kr5G/KcCOVn6ZFAuE0o94/RmQJt3tXpkthY3r1H03s0v8kazgoxddpUzGc82MifdbYn+Ae0PBZeBhOPgZzlzQkxjBOy8MSSqLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7WHC5+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ag6oTSbd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7WHC5+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ag6oTSbd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7WHC5+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ag6oTSbd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7WHC5+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ag6oTSbd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3E2D1F388;
	Tue,  1 Jul 2025 06:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK4VmWjQJMXLGegpwKIelcf4jULWwZmmJVM5UlL1F9g=;
	b=Q7WHC5+BSxQYZPCvB5T78in4Kq7Fb9oI6LhAfVPII067gAXGbNhFPOgK+Zg0DYqV5fYUTq
	dVU42XCUG2TcxWRnaAFiod2Rqug4fPMA7H1qCib3MtUkgLG7UnzS194TxyTkYVngnYysdC
	oHNlqjvdxXMZLlBdLnxY7DK+8R9Noj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK4VmWjQJMXLGegpwKIelcf4jULWwZmmJVM5UlL1F9g=;
	b=Ag6oTSbdUg4CH7w5TFYDMkTD+HsTSCSfBK4e89tQagJLrzfqqBGoHjhQDJBOZQCrh1nHf3
	k5OetXp9E0FdrsBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q7WHC5+B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ag6oTSbd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK4VmWjQJMXLGegpwKIelcf4jULWwZmmJVM5UlL1F9g=;
	b=Q7WHC5+BSxQYZPCvB5T78in4Kq7Fb9oI6LhAfVPII067gAXGbNhFPOgK+Zg0DYqV5fYUTq
	dVU42XCUG2TcxWRnaAFiod2Rqug4fPMA7H1qCib3MtUkgLG7UnzS194TxyTkYVngnYysdC
	oHNlqjvdxXMZLlBdLnxY7DK+8R9Noj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QK4VmWjQJMXLGegpwKIelcf4jULWwZmmJVM5UlL1F9g=;
	b=Ag6oTSbdUg4CH7w5TFYDMkTD+HsTSCSfBK4e89tQagJLrzfqqBGoHjhQDJBOZQCrh1nHf3
	k5OetXp9E0FdrsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D28341364B;
	Tue,  1 Jul 2025 06:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WE3oMVV/Y2jhbgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:25:25 +0000
Message-ID: <b598e57a-fcdb-49f3-9b59-a6804eb60b2e@suse.de>
Date: Tue, 1 Jul 2025 08:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] ata: ahci: Disallow LPM policy control if not
 supported
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-9-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F3E2D1F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/30/25 08:26, Damien Le Moal wrote:
> Commit fa997b0576c9 ("ata: ahci: Do not enable LPM if no LPM states are
> supported by the HBA") introduced an early return in
> ahci_update_initial_lpm_policy() to ensure that the target_lpm_policy
> of ports belonging to a host that does not support the Partial, Slumber
> and DevSleep power states is unchanged and remains set to
> ATA_LPM_UNKNOWN and thus prevents the execution of
> ata_eh_link_set_lpm().
> 
> However, a user or a system daemon (e.g. systemd-udevd) may still
> attempt changing the LPM policy through the sysfs
> link_power_management_policy of the host.
> 
> Improve this to prevent sysfs LPM policy changes by setting the flag
> ATA_FLOAG_NO_LPM for the port of such host, and initialize the port
> target_lpm_policy to ATA_LPM_MAX_POWER to guarantee that no unsupported
> low power state is being used on the port and its link.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/ahci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 34698ae39f55..737f5d1bde11 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1793,7 +1793,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>   	if ((ap->host->flags & ATA_HOST_NO_PART) &&
>   	    (ap->host->flags & ATA_HOST_NO_SSC) &&
>   	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
> -		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
> +		ata_port_warn(ap,
> +			"No LPM states supported, forcing LPM max_power\n");
> +		ap->flags |= ATA_FLAG_NO_LPM;
> +		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>   		return;
>   	}
>   

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
